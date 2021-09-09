#! /usr/bin/python
import argparse
import errno
import json
import os
import shutil


EXAMPLE_CONFIG = """
The JSON data should be a list of objects defining the source artifact and
source path to copy the file from and the destination to copy the file to.

JSON example:
[
    {
        "artifact": "<codepipeline artifact name>",
        "source": "<filepath to get the file from>",
        "target": "<filepath to copy the file to>"
    },
    ...
]

In terraform this can be done with a var of type list(map(string))
passed in as a COPY_ARTIFACTS env var with jsonencode()
"""


def read_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-e",
        action="store_true",
        default=False,
        dest="show_example_config",
        help="Show example config",
    )

    parser.add_argument(
        "-j",
        action="store",
        dest="artifacts_json",
        help="A JSON encoded list of artifacts to copy passed as a string",
    )

    parser.add_argument(
        "-f",
        action="store",
        dest="artifacts_file",
        help="A JSON encoded list of artifacts to copy passed as a file",
    )

    arguments = parser.parse_args()

    if arguments.show_example_config:
        print(EXAMPLE_CONFIG)
        exit()

    return arguments


def load_artifacts(json_config):
    artifacts = None
    try:
        artifacts = json.loads(json_config)
    except json.JSONDecodeError as error:
        print(error)
        exit(1)
    return artifacts


def copy_artifact(artifact):
    copied = False
    try:
        artifact_name = artifact["artifact"]
        codebuild_src_var = f"CODEBUILD_SRC_DIR_{artifact_name}"
        artifact_root = os.environ[codebuild_src_var]
        source_path = f"{artifact_root}/{artifact['source']}"
        target_path = artifact["target"]
        try:
            created = shutil.copytree(source_path, target_path)
        except OSError as error:
            if error.errno in (errno.ENOTDIR, errno.EINVAL):
                created = shutil.copy(source_path, target_path)
            else: raise
        copied = (created == target_path)
    except KeyError as error:
        print(f"Invalid config: {error}")
        exit(1)
    return copied


def copy_artifacts(artifacts):
    copied = [
        copy_artifact(artifact)
        for artifact
        in artifacts
    ]
    return all(copied)


def main():
    arguments = read_arguments()

    if arguments.artifacts_file is not None:
        with open(arguments.artifacts_file, "r") as artifacts_handle:
            artifacts_json = artifacts_handle.read()
    elif arguments.artifacts_json is not None:
        artifacts_json = arguments.artifacts_json

    if artifacts_json:
        artifacts = load_artifacts(artifacts_json)
        copied = copy_artifacts(artifacts)
        print("Done" if copied else "Failed")
    else:
        print("No artifacts found")


if __name__ == "__main__":
    main()
