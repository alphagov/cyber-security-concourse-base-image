#! /usr/bin/python
import argparse
import os
import sys


USAGE = """
Usage get_artifact_path.py -a artifact_name
# prints value of $CODEBUILD_SRC_DIR_artifact_name
OR get_artifact_path.py -a default
# prints value of $CODEBUILD_SRC_DIR
OR get_artifact_path.py -a not_a_real_artifact
# exit(1)s and prints to stderr

examples
SRC=$(get_artifact_path.py -a default)
ZIP=$(get_artifact_path.py -a lambda_zip)
"""

def read_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-a",
        action="store",
        dest="artifact_name",
        help="A string containing the name of a codepipeline artifact",
    )

    arguments = parser.parse_args()

    if not arguments.artifact_name:
        print(USAGE, file=sys.stderr)
        exit(1)

    return arguments


def main():
    artifact_root = "CODEBUILD_SRC_DIR"
    arguments = read_arguments()
    artifact_name = arguments.artifact_name
    try:
        if artifact_name == "default":
            artifact_path = os.environ[artifact_root]
        else:
            artifact_var = f"{artifact_root}_{artifact_name}"
            artifact_path = os.environ[artifact_var]
    except KeyError as error:
        print(f"Artifact missing: {error}", file=sys.stderr)
        exit(1)

    print(artifact_path)

if __name__ == "__main__":
    main()
