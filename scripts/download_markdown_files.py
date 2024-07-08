import os
import requests
from requests.auth import HTTPBasicAuth
import urllib.parse
from xml.etree import ElementTree
import argparse


# Parse command-line arguments
def parse_args():
    parser = argparse.ArgumentParser(description="Download files from WebDAV server.")
    parser.add_argument("hostname", help="WebDAV server hostname")
    parser.add_argument("username", help="WebDAV server username")
    parser.add_argument("password", help="WebDAV server password")
    parser.add_argument(
        "remote_base_path", help="Remote base path on the WebDAV server"
    )
    parser.add_argument("local_base_path", help="Local base path to save files")

    return parser.parse_args()


def list_files(url, auth):
    headers = {"Content-Type": "application/xml", "Depth": "1"}
    response = requests.request("PROPFIND", url, auth=auth, headers=headers)
    if response.status_code != 207:
        raise Exception(f"Failed to list directory contents: {response.status_code}")

    tree = ElementTree.fromstring(response.content)
    files = []
    for response in tree.findall("{DAV:}response"):
        href = response.find("{DAV:}href").text
        if not href.endswith("/"):
            files.append(href)
    return files


def list_folders(url, auth, parent_folder):
    headers = {"Content-Type": "application/xml", "Depth": "1"}
    response = requests.request("PROPFIND", url, auth=auth, headers=headers)
    if response.status_code != 207:
        raise Exception(f"Failed to list directory contents: {response.status_code}")

    tree = ElementTree.fromstring(response.content)
    folders = []
    for response in tree.findall("{DAV:}response"):
        href = response.find("{DAV:}href").text
        folder = os.path.basename(os.path.normpath(href))
        # aux = args.remote_base_path.split("/")[-1]
        if (
            href.endswith("/")
            and href != url + "/"
            and not folder.startswith(".")
            and folder != parent_folder.split("/")[-1]
        ):
            folders.append(folder)
    return folders


def filter_after_global_base_path(path):
    search_str = "/" + args.remote_base_path + "/"
    if search_str in path:
        return path.split(search_str, 1)[1]
    return path


def ensure_folder_exists(path):
    if not os.path.exists(path):
        os.makedirs(path)
        print(f"Folder created: {path}")
    else:
        print(f"Folder already exists: {path}")


def download_files(webdevurl, auth, remote_base_path, local_base_path):
    if not os.path.exists(local_base_path):
        os.makedirs(local_base_path)

    files = list_files(os.path.join(webdevurl, remote_base_path), auth)
    for file_path in files:
        file_name = filter_after_global_base_path(file_path)  # file_path.split("/")[-1]
        # Decoding the URL-encoded string
        decoded_filename = urllib.parse.unquote(file_name)
        remote_file_url = os.path.join(
            webdevurl, remote_base_path, file_path.split("/")[-1]
        )
        local_file_path = os.path.join(local_base_path, decoded_filename)

        response = requests.get(remote_file_url, auth=auth, stream=True)
        if response.status_code == 200:
            folder_path = os.path.dirname(local_file_path)
            ensure_folder_exists(folder_path)
            with open(local_file_path, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
        else:
            print(f"Failed to download {remote_file_url}: {response.status_code}")


def download_all_files_iterative(hostname, auth, remote_base_path, local_base_path):
    # Initialize the stack with the root directory
    stack = [remote_base_path]

    while stack:
        current_remote_path = stack.pop()

        # Download files in the current directory
        download_files(hostname, auth, current_remote_path, local_base_path)

        # List all folders in the current remote path
        base_url = os.path.join(hostname, current_remote_path)
        folders = list_folders(base_url, auth, current_remote_path)

        # Add each subfolder to the stack
        for folder in folders:
            relative_folder_path = os.path.join(current_remote_path, folder)
            stack.append(relative_folder_path)


if __name__ == "__main__":

    args = parse_args()
    auth = HTTPBasicAuth(args.username, args.password)
    download_all_files_iterative(
        args.hostname, auth, args.remote_base_path, args.local_base_path
    )
