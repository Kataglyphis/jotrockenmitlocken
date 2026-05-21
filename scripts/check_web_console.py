#!/usr/bin/env python3
"""Check Flutter web app for issues that would appear in browser console."""

import http.server
import threading
import urllib.request
import urllib.error
import json
import os
import sys
import re
from pathlib import Path

BASE_URL = "http://localhost:8080"
ERRORS = []
WARNINGS = []

def check_url(url, description=""):
    """Check if a URL returns 200."""
    try:
        req = urllib.request.Request(url, method='HEAD')
        with urllib.request.urlopen(req, timeout=5) as resp:
            return resp.status, resp.headers.get('Content-Type', '')
    except urllib.error.HTTPError as e:
        return e.code, ""
    except Exception as e:
        return 0, str(e)

def check_main_page():
    """Check the main index.html page."""
    print("Checking main page...")
    status, content_type = check_url(BASE_URL + "/")
    if status != 200:
        ERRORS.append(f"Main page returned {status}")
        return
    
    # Fetch full content
    with urllib.request.urlopen(BASE_URL + "/", timeout=10) as resp:
        html = resp.read().decode('utf-8')
    
    # Check for flutter_bootstrap.js
    if 'flutter_bootstrap.js' not in html:
        ERRORS.append("flutter_bootstrap.js not referenced in HTML")
    
    # Check for CSP issues
    csp_match = re.search(r'content="([^"]*)"', html)
    if csp_match:
        csp = csp_match.group(1)
        if "'unsafe-eval'" in csp:
            WARNINGS.append("CSP allows 'unsafe-eval' (potential security issue)")
    
    print(f"  Main page: {status} OK")

def check_bootstrap_js():
    """Check flutter_bootstrap.js loads and is valid."""
    print("Checking flutter_bootstrap.js...")
    status, content_type = check_url(BASE_URL + "/flutter_bootstrap.js")
    if status != 200:
        ERRORS.append(f"flutter_bootstrap.js returned {status}")
        return
    
    with urllib.request.urlopen(BASE_URL + "/flutter_bootstrap.js", timeout=10) as resp:
        js = resp.read().decode('utf-8')
    
    # Check for obvious JS syntax issues
    if 'flutter.js' not in js:
        ERRORS.append("flutter_bootstrap.js doesn't reference flutter.js")
    
    print(f"  flutter_bootstrap.js: {status} OK")

def check_flutter_js():
    """Check flutter.js loads."""
    print("Checking flutter.js...")
    status, content_type = check_url(BASE_URL + "/flutter.js")
    if status != 200:
        ERRORS.append(f"flutter.js returned {status}")
    else:
        print(f"  flutter.js: {status} OK")

def check_manifest():
    """Check manifest.json."""
    print("Checking manifest.json...")
    status, content_type = check_url(BASE_URL + "/manifest.json")
    if status != 200:
        ERRORS.append(f"manifest.json returned {status}")
        return
    
    with urllib.request.urlopen(BASE_URL + "/manifest.json", timeout=10) as resp:
        try:
            manifest = json.loads(resp.read().decode('utf-8'))
            print(f"  manifest.json: {status} OK, name={manifest.get('name', 'N/A')}")
        except json.JSONDecodeError as e:
            ERRORS.append(f"manifest.json is invalid JSON: {e}")

def check_favicon():
    """Check favicon."""
    print("Checking favicon...")
    status, _ = check_url(BASE_URL + "/favicon.png")
    if status != 200:
        WARNINGS.append(f"favicon.png returned {status}")
    else:
        print(f"  favicon.png: {status} OK")

def check_icons():
    """Check PWA icons."""
    print("Checking PWA icons...")
    for icon in ["icons/Icon-192.png", "icons/Icon-512.png", "icons/Icon-maskable-192.png", "icons/Icon-maskable-512.png"]:
        status, _ = check_url(BASE_URL + f"/{icon}")
        if status != 200:
            WARNINGS.append(f"{icon} returned {status}")
        else:
            print(f"  {icon}: {status} OK")

def check_css_files():
    """Check CSS files referenced in HTML."""
    print("Checking CSS files...")
    with urllib.request.urlopen(BASE_URL + "/", timeout=10) as resp:
        html = resp.read().decode('utf-8')
    
    css_files = re.findall(r'href="([^"]*\.css)"', html)
    for css in css_files:
        if css.startswith('http'):
            continue
        status, _ = check_url(BASE_URL + f"/{css}")
        if status != 200:
            ERRORS.append(f"CSS file {css} returned {status}")
        else:
            print(f"  {css}: {status} OK")

def check_assets():
    """Check common asset files."""
    print("Checking assets...")
    # Check fonts
    fonts = [
        "static/Montserrat-Regular.ttf",
        "static/Montserrat-Bold.ttf",
        "Roboto-Regular.ttf",
        "Roboto-Bold.ttf",
    ]
    for font in fonts:
        status, _ = check_url(BASE_URL + f"/{font}")
        if status != 200:
            WARNINGS.append(f"Font {font} returned {status}")
        else:
            print(f"  {font}: {status} OK")
    
    # Check images
    images = [
        "assets/images/logo.png",
        "assets/images/barbell.png",
    ]
    for img in images:
        status, _ = check_url(BASE_URL + f"/{img}")
        if status != 200:
            WARNINGS.append(f"Image {img} returned {status}")
        else:
            print(f"  {img}: {status} OK")

def check_wasm_files():
    """Check WASM files."""
    print("Checking WASM files...")
    with urllib.request.urlopen(BASE_URL + "/", timeout=10) as resp:
        html = resp.read().decode('utf-8')
    
    # Look for .wasm references
    wasm_files = re.findall(r'["\']([^"\']*\.wasm)["\']', html)
    # Also check flutter_bootstrap.js for wasm references
    try:
        with urllib.request.urlopen(BASE_URL + "/flutter_bootstrap.js", timeout=10) as resp:
            js = resp.read().decode('utf-8')
        wasm_files.extend(re.findall(r'["\']([^"\']*\.wasm)["\']', js))
    except:
        pass
    
    for wasm in set(wasm_files):
        if wasm.startswith('http'):
            continue
        status, _ = check_url(BASE_URL + f"/{wasm}")
        if status != 200:
            ERRORS.append(f"WASM file {wasm} returned {status}")
        else:
            print(f"  {wasm}: {status} OK")

def check_js_syntax():
    """Check JS files for obvious syntax errors."""
    print("Checking JS files for syntax issues...")
    with urllib.request.urlopen(BASE_URL + "/", timeout=10) as resp:
        html = resp.read().decode('utf-8')
    
    js_files = re.findall(r'src="([^"]*\.js)"', html)
    for js in js_files:
        if js.startswith('http'):
            continue
        status, content_type = check_url(BASE_URL + f"/{js}")
        if status == 200:
            with urllib.request.urlopen(BASE_URL + f"/{js}", timeout=10) as resp:
                content = resp.read().decode('utf-8')
            # Check for common issues
            if 'undefined is not a function' in content:
                ERRORS.append(f"{js} contains 'undefined is not a function'")
            if 'Cannot read property' in content:
                WARNINGS.append(f"{js} contains 'Cannot read property' string")
            print(f"  {js}: {status} OK")

def run_checks():
    """Run all checks."""
    print("=" * 60)
    print("Flutter Web App Console Error Checker")
    print("=" * 60)
    
    check_main_page()
    check_bootstrap_js()
    check_flutter_js()
    check_manifest()
    check_favicon()
    check_icons()
    check_css_files()
    check_assets()
    check_wasm_files()
    check_js_syntax()
    
    print("\n" + "=" * 60)
    print("RESULTS")
    print("=" * 60)
    
    if ERRORS:
        print(f"\nERRORS ({len(ERRORS)}):")
        for e in ERRORS:
            print(f"  ❌ {e}")
    
    if WARNINGS:
        print(f"\nWARNINGS ({len(WARNINGS)}):")
        for w in WARNINGS:
            print(f"  ⚠️  {w}")
    
    if not ERRORS and not WARNINGS:
        print("\n✅ No issues found!")
    
    print(f"\nTotal: {len(ERRORS)} errors, {len(WARNINGS)} warnings")
    return len(ERRORS) == 0

if __name__ == "__main__":
    success = run_checks()
    sys.exit(0 if success else 1)
