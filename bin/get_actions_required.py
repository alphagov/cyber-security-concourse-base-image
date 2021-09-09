#! /usr/bin/python
import argparse
import json
import os

USAGE = """
Usage: get_actions_required.py \
  -c path/to/changed_files.json
  -t path/to/action_triggers.json
  -o path/to/required/output/actions_required.json

Examples:
- (input) changed_files.json

[
    "docker/Dockerfile"
]

- (input) action_triggers.json

[
    {
        "action": "BuildContainer",
        "trigger_paths": [
            "docker/Dockerfile",
            "docker/bin"
        ]
    },
    {
        "action": "DoSomethingElse",
        "trigger_paths": [
            "somewhere/else/changed"
        ]
    }
]

- (output) actions_required.json

[
    {
        "action": "BuildContainer",
        "required": true
    },
    {
        "action": "SomethingElse",
        "required": false
    }
]

"""


def get_json_from_file(file_path: str):
    with open(file_path, "r") as json_file:
        file_content = json.load(json_file)
        return file_content


def write_json_to_file(file_path: str, data: str):
    with open(file_path, "w") as outfile:
        json.dump(data, outfile)


def does_path_exist_in_changed_files(action_triggers, changed_files) -> bool:
    return any(
        [
            trigger
            for trigger in action_triggers
            if any(changed_file.startswith(trigger) for changed_file in changed_files)
        ]
    )


def read_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-c",
        action="store",
        dest="changed_files_json",
        help="A JSON file containing the list of files changed in the PR",
    )

    parser.add_argument(
        "-t",
        action="store",
        dest="action_triggers_json",
        help="A JSON file containing the list of pipeline actions and paths that should trigger them",
    )

    parser.add_argument(
        "-o",
        action="store",
        dest="output_actions_file",
        help="The path and filename to save the output file to",
    )

    arguments = parser.parse_args()

    if not all(
        [
            arguments.changed_files_json,
            arguments.action_triggers_json,
            arguments.output_actions_file,
        ]
    ):
        print(USAGE)
        exit(1)

    return arguments


def main():
    arguments = read_arguments()
    changed_files_content = get_json_from_file(arguments.changed_files_json)
    action_triggers_content = get_json_from_file(arguments.action_triggers_json)
    actions_required = [
        {
            "action": trigger["action"],
            "required": does_path_exist_in_changed_files(
                trigger["trigger_paths"], changed_files_content
            ),
        }
        for trigger in action_triggers_content
    ]
    write_json_to_file(arguments.output_actions_file, actions_required)


if __name__ == "__main__":
    main()
