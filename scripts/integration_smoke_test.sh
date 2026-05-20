#!/usr/bin/env bash
# Integration smoke test for the built web app.
# Requires: curl, a web server serving build/web/ on port 8080.
# Usage: ./scripts/integration_smoke_test.sh [base_url]

set -euo pipefail
BASE_URL="${1:-http://localhost:8080}"

echo "=== Integration Smoke Test ==="
echo "Target: $BASE_URL"
echo ""

# 1. Verify index.html loads
echo "--- Testing: index.html loads ---"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/")
if [ "$STATUS" != "200" ]; then
  echo "FAIL: index.html returned HTTP $STATUS"
  exit 1
fi
echo "PASS: index.html HTTP 200"

# 2. Verify main.dart.wasm serves with correct MIME type
echo "--- Testing: main.dart.wasm MIME type ---"
WASM_MIME=$(curl -s -I "$BASE_URL/main.dart.wasm" | grep -i "content-type:" | tr -d '\r')
if echo "$WASM_MIME" | grep -q "application/wasm"; then
  echo "PASS: WASM MIME type correct"
else
  echo "FAIL: WASM MIME type: $WASM_MIME"
  exit 1
fi

# 3. Verify main.dart.js exists and serves
echo "--- Testing: main.dart.js exists ---"
JS_SIZE=$(curl -s -o /dev/null -w "%{size_download}" "$BASE_URL/main.dart.js")
if [ "$JS_SIZE" -gt 10000 ]; then
  echo "PASS: main.dart.js served ($JS_SIZE bytes)"
else
  echo "FAIL: main.dart.js too small or missing ($JS_SIZE bytes)"
  exit 1
fi

# 4. Verify flutter_bootstrap.js exists
echo "--- Testing: flutter_bootstrap.js exists ---"
BOOT_SIZE=$(curl -s -o /dev/null -w "%{size_download}" "$BASE_URL/flutter_bootstrap.js")
if [ "$BOOT_SIZE" -gt 100 ]; then
  echo "PASS: flutter_bootstrap.js served ($BOOT_SIZE bytes)"
else
  echo "FAIL: flutter_bootstrap.js missing"
  exit 1
fi

# 5. Verify manifest.json exists
echo "--- Testing: manifest.json ---"
MANIFEST=$(curl -s "$BASE_URL/manifest.json")
if echo "$MANIFEST" | grep -q '"name"'; then
  echo "PASS: manifest.json valid"
else
  echo "FAIL: manifest.json invalid"
  exit 1
fi

# 6. Verify CSP header or meta tag
echo "--- Testing: CSP present ---"
CSP=$(curl -s "$BASE_URL/" | grep -c "Content-Security-Policy" || true)
if [ "$CSP" -gt 0 ]; then
  echo "PASS: CSP found in HTML"
else
  echo "WARN: No CSP in HTML"
fi

# 7. Verify .htaccess (if Apache) or response headers
echo "--- Testing: Security headers ---"
HEADERS=$(curl -s -I "$BASE_URL/")
if echo "$HEADERS" | grep -q "X-Content-Type-Options"; then
  echo "PASS: X-Content-Type-Options present"
else
  echo "INFO: Security headers not sent (may be static file server)"
fi

# 8. Verify CSP allows CanvasKit CDN (gstatic.com) for WASM fallback
echo "--- Testing: CSP allows CanvasKit CDN ---"
HTML=$(curl -s "$BASE_URL/")
CSP=$(echo "$HTML" | grep -o 'content="[^"]*Content-Security-Policy[^"]*"' || echo "$HTML" | grep -o 'content="[^"]*"')
if echo "$CSP" | grep -q "www.gstatic.com"; then
  echo "PASS: gstatic.com in CSP"
else
  echo "FAIL: gstatic.com missing from CSP (CanvasKit fallback will break)"
  exit 1
fi

# 9. Verify CSP allows Google Fonts CDN
echo "--- Testing: CSP allows Google Fonts ---"
if echo "$CSP" | grep -q "fonts.gstatic.com"; then
  echo "PASS: fonts.gstatic.com in CSP"
else
  echo "FAIL: fonts.gstatic.com missing from CSP (fonts will break)"
  exit 1
fi

# 10. Verify CSP script-src includes gstatic.com
echo "--- Testing: script-src allows gstatic.com ---"
if echo "$CSP" | grep -q "script-src[^;]*www.gstatic.com"; then
  echo "PASS: script-src permits gstatic.com"
else
  echo "FAIL: script-src missing gstatic.com (CanvasKit JS blocked)"
  exit 1
fi

# 11. Verify loading screen JS uses MutationObserver (not fixed timer)
echo "--- Testing: loading screen uses MutationObserver ---"
if echo "$HTML" | grep -q "MutationObserver"; then
  echo "PASS: MutationObserver-based loading screen present"
else
  echo "WARN: MutationObserver not found in loading script"
fi

# 12. Verify loading screen has hideLoading function
echo "--- Testing: loading screen has hideLoading ---"
if echo "$HTML" | grep -q "hideLoading"; then
  echo "PASS: hideLoading function present"
else
  echo "WARN: hideLoading function not found"
fi

echo ""
echo "=== All critical checks passed ==="
