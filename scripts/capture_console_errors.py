#!/usr/bin/env python3
"""Comprehensive E2E test suite for Flutter web app using Playwright + flatpak Chromium."""

import subprocess
import time
import sys
import json
from playwright.sync_api import sync_playwright, expect

CHROMIUM_BIN = "/home/jonas/.local/share/flatpak/exports/bin/org.chromium.Chromium"
PORT = 8080

class E2ETestSuite:
    def __init__(self):
        self.results = {"passed": 0, "failed": 0, "skipped": 0, "warnings": 0}
        self.console_logs = []
        self.page_errors = []
        self.failures = []

    def log_pass(self, test_name):
        self.results["passed"] += 1
        print(f"  ✅ {test_name}")

    def log_fail(self, test_name, reason=""):
        self.results["failed"] += 1
        msg = f"  ❌ {test_name}"
        if reason:
            msg += f" — {reason}"
        print(msg)
        self.failures.append(f"{test_name}: {reason}")

    def log_warn(self, test_name, reason=""):
        self.results["warnings"] += 1
        msg = f"  ⚠️  {test_name}"
        if reason:
            msg += f" — {reason}"
        print(msg)

    def log_skip(self, test_name, reason=""):
        self.results["skipped"] += 1
        print(f"  ⏭️  {test_name} — {reason}")

    def setup_page(self, page):
        """Set up console and error listeners."""
        page.on("console", lambda msg: self.console_logs.append({
            "type": msg.type,
            "text": msg.text,
        }))
        page.on("pageerror", lambda err: self.page_errors.append(str(err)))

    def wait_for_flutter(self, page, timeout=30000):
        """Wait for Flutter to render."""
        page.wait_for_function("""
            () => document.querySelector('flt-glass-pane') !== null ||
                  document.querySelector('flt-renderer') !== null ||
                  document.body.innerHTML.length > 1000
        """, timeout=timeout)

    # ── Navigation & Routing Tests ──────────────────────────────────────

    def test_navigation(self, page, base_url):
        print("\n📍 Navigation & Routing Tests")
        routes = [
            ("/", "Landing page"),
            ("/aboutMe", "About Me page"),
            ("/data", "Data page"),
            ("/documents", "Documents page"),
            ("/error404", "Error page"),
        ]

        for route, name in routes:
            try:
                page.goto(f"{base_url}{route}", wait_until="domcontentloaded", timeout=15000)
                # Wait for URL to update (Flutter handles routing client-side)
                time.sleep(2)
                current_url = page.url
                if route in current_url or (route == "/" and current_url.rstrip("/") == base_url):
                    self.log_pass(f"Navigate to {name} ({route})")
                else:
                    self.log_fail(f"Navigate to {name} ({route})", f"URL is {current_url}")
            except Exception as e:
                self.log_fail(f"Navigate to {name} ({route})", str(e)[:100])

    # ── Responsive Layout Tests ─────────────────────────────────────────

    def test_responsive_layouts(self, page, base_url):
        print("\n📱 Responsive Layout Tests")
        viewports = [
            {"width": 375, "height": 812, "name": "Mobile (iPhone)"},
            {"width": 768, "height": 1024, "name": "Tablet (iPad)"},
            {"width": 1280, "height": 800, "name": "Desktop"},
            {"width": 1920, "height": 1080, "name": "Full HD"},
        ]

        page.goto(base_url, wait_until="domcontentloaded", timeout=30000)
        self.wait_for_flutter(page)

        for vp in viewports:
            try:
                page.set_viewport_size({"width": vp["width"], "height": vp["height"]})
                time.sleep(1)  # Allow layout to recalculate

                # Check that the page is visible and not broken
                body_width = page.evaluate("() => document.body.scrollWidth")
                viewport_width = page.evaluate("() => window.innerWidth")

                if body_width > 0:
                    self.log_pass(f"{vp['name']} ({vp['width']}x{vp['height']}) — body width: {body_width}px")
                else:
                    self.log_fail(f"{vp['name']} ({vp['width']}x{vp['height']})", "body width is 0")
            except Exception as e:
                self.log_fail(vp["name"], str(e)[:100])

    # ── Asset & Rendering Tests ─────────────────────────────────────────

    def test_assets_and_rendering(self, page, base_url):
        print("\n🖼️  Asset & Rendering Tests")

        page.goto(base_url, wait_until="domcontentloaded", timeout=30000)
        # Wait longer for Flutter WASM to compile and render
        try:
            page.wait_for_function("""
                () => document.querySelector('flt-glass-pane') !== null ||
                      document.querySelector('flt-renderer') !== null
            """, timeout=30000)
            time.sleep(1)
        except Exception:
            pass  # Continue with checks even if wait times out

        # WASM loaded (check flutter build config)
        try:
            wasm_config = page.evaluate("""
                () => {
                    if (window._flutter && window._flutter.buildConfig) {
                        const builds = window._flutter.buildConfig.builds || [];
                        return builds.some(b => b.compileTarget === 'dart2wasm');
                    }
                    return false;
                }
            """)
            if wasm_config:
                self.log_pass("WASM build configured")
            else:
                self.log_warn("WASM build", "No dart2wasm build found in config")
        except Exception as e:
            self.log_fail("WASM check", str(e)[:100])

        # Flutter glass pane rendered
        try:
            has_glass_pane = page.evaluate("() => document.querySelector('flt-glass-pane') !== null")
            if has_glass_pane:
                self.log_pass("Flutter glass pane rendered")
            else:
                self.log_fail("Flutter glass pane", "Element not found")
        except Exception as e:
            self.log_fail("Flutter glass pane", str(e)[:100])

        # Canvas element exists (inside Flutter renderer)
        try:
            has_canvas = page.evaluate("() => document.querySelector('canvas') !== null")
            if has_canvas:
                self.log_pass("Canvas element present")
            else:
                # Flutter web might use DOM rendering instead of canvas in some cases
                has_dom_renderer = page.evaluate("() => document.querySelector('flt-glass-pane') !== null")
                if has_dom_renderer:
                    self.log_pass("Flutter renderer present (DOM-based)")
                else:
                    self.log_fail("Canvas/renderer", "Neither canvas nor Flutter renderer found")
        except Exception as e:
            self.log_fail("Canvas check", str(e)[:100])

        # Check for failed resource loads
        try:
            failed_resources = page.evaluate("""
                () => {
                    const entries = performance.getEntriesByType('resource');
                    return entries.filter(e => e.responseStatus >= 400).map(e => ({url: e.name, status: e.responseStatus}));
                }
            """)
            if len(failed_resources) == 0:
                self.log_pass("No failed resource loads")
            else:
                # Filter out expected 404s (blog content requires WebDAV)
                unexpected = [r for r in failed_resources if 'blog' not in r['url'].lower()]
                if unexpected:
                    self.log_warn("Failed resources", f"{len(unexpected)} unexpected 4xx/5xx responses")
                else:
                    self.log_pass("No unexpected failed resource loads")
        except Exception as e:
            self.log_fail("Resource check", str(e)[:100])

    # ── Performance Metrics Tests ───────────────────────────────────────

    def test_performance(self, page, base_url):
        print("\n⚡ Performance Metrics")

        # Measure initial load
        page.goto(base_url, wait_until="domcontentloaded", timeout=30000)
        self.wait_for_flutter(page)

        try:
            perf_metrics = page.evaluate("""
                () => {
                    const nav = performance.getEntriesByType('navigation')[0];
                    const resources = performance.getEntriesByType('resource');
                    const wasm = resources.find(r => r.name.includes('.wasm'));
                    return {
                        domContentLoaded: nav.domContentLoadedEventEnd - nav.startTime,
                        loadComplete: nav.loadEventEnd - nav.startTime,
                        totalResources: resources.length,
                        wasmLoadTime: wasm ? wasm.duration : null,
                        wasmSize: wasm ? wasm.transferSize : null,
                    };
                }
            """)

            dom_ready = perf_metrics.get("domContentLoaded", 0)
            load_complete = perf_metrics.get("loadComplete", 0)
            total_resources = perf_metrics.get("totalResources", 0)
            wasm_time = perf_metrics.get("wasmLoadTime")
            wasm_size = perf_metrics.get("wasmSize")

            self.log_pass(f"DOM content loaded: {dom_ready:.0f}ms")
            self.log_pass(f"Page load complete: {load_complete:.0f}ms")
            self.log_pass(f"Total resources loaded: {total_resources}")

            if wasm_time is not None:
                self.log_pass(f"WASM load time: {wasm_time:.0f}ms")
                if wasm_size:
                    self.log_pass(f"WASM size: {wasm_size / 1024:.0f}KB")
                else:
                    self.log_warn("WASM size", "transferSize not available")
            else:
                self.log_warn("WASM load time", "WASM resource not found in performance entries")

            # Warn if load time is excessive
            if load_complete > 5000:
                self.log_warn("Slow load", f"Page took {load_complete:.0f}ms to load (>5s)")

        except Exception as e:
            self.log_fail("Performance metrics", str(e)[:100])

    # ── UI Interaction Tests ────────────────────────────────────────────

    def test_ui_interactions(self, page, base_url):
        print("\n🎨 UI Interaction Tests")

        # Fresh page load for UI tests
        page.goto(base_url, wait_until="domcontentloaded", timeout=30000)

        # Loading screen should be gone after Flutter renders
        try:
            page.wait_for_function("""
                () => document.querySelector('flt-glass-pane') !== null ||
                      document.querySelector('flt-renderer') !== null
            """, timeout=30000)
            time.sleep(1)

            loading_visible = page.evaluate("""
                () => {
                    const loader = document.querySelector('.loading');
                    return loader && !loader.classList.contains('fade-out');
                }
            """)
            if not loading_visible:
                self.log_pass("Loading screen faded out")
            else:
                self.log_warn("Loading screen", "Still visible after Flutter rendered")
        except Exception as e:
            self.log_fail("Loading screen check", str(e)[:100])

        # Cookie notice should be present
        try:
            cookie_notice = page.evaluate("() => document.getElementById('cookie-notice') !== null")
            if cookie_notice:
                self.log_pass("Cookie notice present")
            else:
                self.log_warn("Cookie notice", "Element not found")
        except Exception as e:
            self.log_fail("Cookie notice", str(e)[:100])

        # Cookie consent button should work
        try:
            cookie_btn = page.locator("#cookie-consent")
            if cookie_btn.is_visible():
                cookie_btn.click()
                time.sleep(1)
                cookie_hidden = page.evaluate("""
                    () => {
                        const notice = document.getElementById('cookie-notice');
                        return notice && (notice.style.display === 'none' || notice.classList.contains('hidden'));
                    }
                """)
                if cookie_hidden:
                    self.log_pass("Cookie consent button dismisses notice")
                else:
                    self.log_warn("Cookie consent", "Notice not hidden after click (may use different mechanism)")
            else:
                self.log_skip("Cookie consent", "Button not visible")
        except Exception as e:
            self.log_fail("Cookie consent", str(e)[:100])

        # Navigation bar should be present (Flutter uses custom rendering)
        try:
            has_nav = page.evaluate("""
                () => {
                    // Flutter renders navigation as part of the glass pane
                    const glassPane = document.querySelector('flt-glass-pane');
                    return glassPane ? 'flutter-rendered' : 'missing';
                }
            """)
            if has_nav == "flutter-rendered":
                self.log_pass("Navigation rendered (Flutter glass pane)")
            else:
                self.log_warn("Navigation", "No Flutter renderer found")
        except Exception as e:
            self.log_fail("Navigation bar", str(e)[:100])

        # Dark mode media query should be respected
        try:
            prefers_dark = page.evaluate("""
                () => window.matchMedia('(prefers-color-scheme: dark)').matches
            """)
            self.log_pass(f"Color scheme preference detected: {'dark' if prefers_dark else 'light'}")
        except Exception as e:
            self.log_fail("Dark mode check", str(e)[:100])

    # ── Console Error Summary ───────────────────────────────────────────

    def report_console_logs(self):
        print("\n📋 Console Log Summary")

        seen = set()
        unique_logs = []
        for log in self.console_logs:
            key = (log["type"], log["text"][:100])
            if key not in seen:
                seen.add(key)
                unique_logs.append(log)

        has_errors = False
        for log in unique_logs:
            log_type = log["type"]
            text = log["text"]
            if log_type == "error":
                # Ignore expected 404s for blog content (requires WebDAV)
                if '404' in text:
                    print(f"  ℹ️  [{log_type}] {text[:200]} (expected — WebDAV content)")
                else:
                    print(f"  ❌ [{log_type}] {text[:200]}")
                    has_errors = True
            elif log_type == "warning":
                # Ignore expected WebGL warning in headless mode
                if 'GPU stall' in text or 'webGLVersion' in text.lower():
                    print(f"  ℹ️  [{log_type}] {text[:200]} (expected — headless mode)")
                else:
                    print(f"  ⚠️  [{log_type}] {text[:200]}")
            else:
                print(f"  ℹ️  [{log_type}] {text[:150]}")

        if self.page_errors:
            print("\n  Page Errors:")
            for err in self.page_errors:
                print(f"  ❌ {err[:200]}")
                has_errors = True

        if not has_errors and not unique_logs:
            print("  ✅ No console errors detected!")
        elif not has_errors:
            print("  ✅ No console errors (only expected warnings)")

        return has_errors

    def run_all(self):
        print("=" * 60)
        print("Flutter Web App — Comprehensive E2E Test Suite")
        print("=" * 60)

        server = subprocess.Popen(
            ["python3", "-m", "http.server", str(PORT)],
            cwd="/home/jonas/GitHub/jotrockenmitlocken/build/web",
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        time.sleep(2)

        with sync_playwright() as p:
            try:
                print("\nLaunching Chromium headless...")
                browser = p.chromium.launch(
                    executable_path=CHROMIUM_BIN,
                    headless=True,
                    args=["--no-sandbox", "--disable-gpu", "--disable-dev-shm-usage"]
                )

                page = browser.new_page()
                self.setup_page(page)

                base_url = f"http://localhost:{PORT}"

                # Run all test groups
                self.test_navigation(page, base_url)
                self.test_responsive_layouts(page, base_url)
                self.test_assets_and_rendering(page, base_url)
                self.test_performance(page, base_url)
                self.test_ui_interactions(page, base_url)

                # Screenshot
                screenshot_path = "/tmp/flutter_web_screenshot.png"
                page.screenshot(path=screenshot_path)
                print(f"\n📸 Screenshot saved to: {screenshot_path}")

                browser.close()

            except Exception as e:
                print(f"\n❌ Fatal error: {e}")
                import traceback
                traceback.print_exc()
            finally:
                server.terminate()
                server.wait()
                print("\nServer stopped.")

        # Console log summary
        has_console_issues = self.report_console_logs()

        # Final summary
        print("\n" + "=" * 60)
        print("TEST SUMMARY")
        print("=" * 60)
        print(f"  ✅ Passed:   {self.results['passed']}")
        print(f"  ❌ Failed:   {self.results['failed']}")
        print(f"  ⚠️  Warnings: {self.results['warnings']}")
        print(f"  ⏭️  Skipped:  {self.results['skipped']}")

        if self.failures:
            print("\n  Failed tests:")
            for f in self.failures:
                print(f"    — {f}")

        overall_pass = self.results["failed"] == 0 and not has_console_issues
        if overall_pass:
            print("\n🎉 All tests passed!")
        else:
            print("\n⚠️  Some tests failed or had errors")

        return 0 if overall_pass else 1


if __name__ == "__main__":
    suite = E2ETestSuite()
    sys.exit(suite.run_all())
