import json
import os


def get_json_from_file(file: str):
    with open(file) as json_file:
        changed_files = json.load(json_file)
        return changed_files


def write_json_to_file(file: str, data: bool):
    with open(file, "w") as outfile:
        json.dump(data, outfile)


def does_path_exist_in_changed_files(action_triggers, changed_files) -> bool:
    return any(
        [
            trigger
            for trigger in action_triggers
            if any(changed_file.startswith(trigger) for changed_file in changed_files)
        ]
    )


def main():
    source_path = os.getenv("CODEBUILD_SRC_DIR")
    changed_files = os.getenv("CODEBUILD_SRC_DIR_changed_files")
    changed_files_content = get_json_from_file(changed_files + "/changed_files.json")

    actions_triggers = os.getenv("ACTION_TRIGGERS")
    actions_triggers_path = source_path + actions_triggers
    actions_triggers_content = get_json_from_file(actions_triggers_path)
    actions_required = [
        {
            "action": trigger["action"],
            "required": does_path_exist_in_changed_files(
                trigger["trigger_paths"], changed_files_content
            ),
        }
        for trigger in actions_triggers_content
    ]
    write_json_to_file(source_path + "/actions_required.json", actions_required)


main()
