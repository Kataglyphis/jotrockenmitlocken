#!/usr/bin/env python3
"""check-live-site.py <base URL>: the hub's live-site check over this site's routes and build/web, after a deploy."""

import json
import subprocess
import sys
from pathlib import Path

from capture_console_errors import ROUTES

REPO = Path(__file__).resolve().parent.parent
BUILD = REPO / "build" / "web"
# The posts and reviews come with the WebDAV content, so the build's own settings name them.
CONTENT_SETTINGS = ("blog_settings.json", "my_two_cents_settings.json")


def routes() -> list[str]:
    """Every route the deployed build serves, as hash URLs (the app uses the hash strategy)."""
    found = list(ROUTES)
    for name in CONTENT_SETTINGS:
        settings = BUILD / "assets" / "assets" / "settings" / name
        if settings.is_file():
            found += [entry["routingName"] for entry in json.loads(settings.read_text(encoding="utf-8"))]
    return [f"/#{route}" for route in dict.fromkeys(found)]


def main() -> int:
    if len(sys.argv) != 2 or not sys.argv[1].startswith("https://"):
        print(__doc__, file=sys.stderr)
        return 2
    if not (BUILD / "index.html").is_file():
        print(f"no build at {BUILD}: run after the deployed build", file=sys.stderr)
        return 2
    check = REPO / "third_party" / "ANTfrastructure" / "linux" / "scripts" / "check-live-site.js"
    return subprocess.call(["node", str(check), sys.argv[1], *routes(), "--files", str(BUILD)])


if __name__ == "__main__":
    sys.exit(main())
