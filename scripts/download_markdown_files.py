import os
import requests
from requests.auth import HTTPBasicAuth
import urllib.parse
from xml.etree import ElementTree
import argparse

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Download files from WebDAV server.")
parser.add_argument("hostname", help="WebDAV server hostname")
parser.add_argument("username", help="WebDAV server username")
parser.add_argument("password", help="WebDAV server password")
parser.add_argument("remote_base_path", help="Remote base path on the WebDAV server")
parser.add_argument("local_base_path", help="Local base path to save files")

args = parser.parse_args()


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


def list_folders(url, auth):
    headers = {"Content-Type": "application/xml", "Depth": "1"}
    response = requests.request("PROPFIND", url, auth=auth, headers=headers)
    if response.status_code != 207:
        raise Exception(f"Failed to list directory contents: {response.status_code}")

    tree = ElementTree.fromstring(response.content)
    folders = []
    for response in tree.findall("{DAV:}response"):
        href = response.find("{DAV:}href").text
        if (
            href.endswith("/")
            and href != url + "/"
            and not href.split("/")[-2].startswith(".")
            and href.split("/")[-2] != args.remote_base_path.split("/")[-2]
        ):
            folders.append(href.split("/")[-2])
    return folders


def download_files(webdevurl, auth, remote_base_path, local_base_path):
    if not os.path.exists(local_base_path):
        os.makedirs(local_base_path)

    files = list_files(os.path.join(webdevurl, remote_base_path), auth)
    for file_path in files:
        file_name = file_path.split("/")[-1]
        # Decoding the URL-encoded string
        decoded_filename = urllib.parse.unquote(file_name)
        remote_file_url = os.path.join(webdevurl, remote_base_path, file_name)
        local_file_path = os.path.join(local_base_path, decoded_filename)

        response = requests.get(remote_file_url, auth=auth, stream=True)
        if response.status_code == 200:
            with open(local_file_path, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
        else:
            print(f"Failed to download {remote_file_url}: {response.status_code}")


if __name__ == "__main__":

    auth = HTTPBasicAuth(args.username, args.password)
    # download_files(args.hostname, auth, args.remote_base_path, args.local_base_path)

    # List all folders in the specified remote base path
    base_url = os.path.join(args.hostname, args.remote_base_path)
    folders = list_folders(base_url, auth)

    # Loop over each folder and download files
    for folder in folders:
        relative_folder_path = os.path.relpath(folder, args.hostname)
        local_folder_path = os.path.join(
            args.local_base_path, os.path.basename(relative_folder_path)
        )
        download_files(args.hostname, auth, relative_folder_path, local_folder_path)
