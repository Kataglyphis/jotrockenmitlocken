import argparse
from kataglyphis_webdavclient.webdavclient import WebDavClient


# Parse command-line arguments
def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Download files from WebDAV server.")
    parser.add_argument("hostname", help="WebDAV server hostname")
    parser.add_argument("username", help="WebDAV server username")
    parser.add_argument("password", help="WebDAV server password")
    parser.add_argument(
        "remote_base_path", help="Remote base path on the WebDAV server"
    )
    parser.add_argument("local_base_path", help="Local base path to save files")

    return parser.parse_args()


if __name__ == "__main__":

    args: argparse.Namespace = parse_args()

    webdevclient = WebDavClient(args.hostname, args.username, args.password)
    webdevclient.download_all_files_iterative(
        args.remote_base_path, args.local_base_path
    )
