import json
import os


def get_json_from_file(file: str):
    with open(file) as json_file:
        changed_files = json.load(json_file)
        return changed_files


def write_json_to_file(file: str, data: bool):
    with open(file, "w") as outfile:
        json.dump(data, outfile)


def does_path_exist_in_changed_files(context_files, changed_files) -> bool:
    return any([
        context_file
        for context_file in context_files
        if any(
            changed_file.startswith(context_file) for changed_file in changed_files
        )
    ])


def main():
    source_path = os.getenv("CODEBUILD_SRC_DIR")
    git_diff_file = os.getenv("OUTPUT_FILENAME")
    changed_files = get_json_from_file(git_diff_file)

    context_files = os.getenv("CONTEXT_FILE_LIST")
    context_files_updated = does_path_exist_in_changed_files(context_files, changed_files)
    print(f"setting rebuild_task to {context_files_updated}")
    write_json_to_file(source_path + "/rebuild_task.json", context_files_updated)


main()
