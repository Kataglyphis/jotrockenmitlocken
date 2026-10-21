#!/usr/bin/env python3
"""Delegate to the shared ANTfrastructure Flutter web console test, over this site's routes."""

import os
import subprocess
import sys
from pathlib import Path

# Every page the site serves without its WebDAV content, and an unknown route that must land on the error page.
ROUTES = [
    "/",
    "/landingPage",
    "/aboutMe",
    "/data",
    "/documents",
    "/quotations",
    "/books",
    "/films",
    "/games",
    "/blockEntries",
    "/sqliteTest",
    "/aiBlog",
    "/rendering",
    "/imprint",
    "/contact",
    "/privacyPolicy",
    "/cookieDeclaration",
    "/declarationOnAccessibility",
    "/copyright",
    "/openSourceLicenses",
    "/error404",
]


def main() -> int:
    repo_root = Path(__file__).resolve().parent.parent
    shared_script = (
        repo_root
        / "third_party"
        / "ANTfrastructure"
        / "linux"
        / "webserver"
        / "scripts"
        / "flutter_capture_console_errors.py"
    )

    if not shared_script.is_file():
        print(f"Shared console test not found: {shared_script}")
        return 1

    command = [
        sys.executable,
        str(shared_script),
        "--build-dir",
        str(repo_root / "build" / "web"),
    ]
    for route in ROUTES:
        command += ["--route", route]
    # The family image ships Chrome for Testing and names it; elsewhere the shared script's flatpak Chromium default holds.
    if os.environ.get("CHROME_EXECUTABLE"):
        command += ["--chromium-bin", os.environ["CHROME_EXECUTABLE"]]
    return subprocess.call(command + sys.argv[1:])


if __name__ == "__main__":
    sys.exit(main())
