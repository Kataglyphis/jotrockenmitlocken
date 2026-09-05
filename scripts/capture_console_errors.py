#!/usr/bin/env python3
"""Delegate to the shared ContainerHub Flutter web console test."""

import subprocess
import sys
from pathlib import Path


def main() -> int:
    script_dir = Path(__file__).resolve().parent
    shared_script = (
        script_dir.parent
        / "third_party"
        / "ContainerHub"
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
        str(script_dir.parent / "build" / "web"),
    ]
    return subprocess.call(command)


if __name__ == "__main__":
    sys.exit(main())
