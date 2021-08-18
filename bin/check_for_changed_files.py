import json
import os

def get_json_from_file(file: str):
    print(f"file: {file}")
    with open(file) as json_file:
        changed_files = json.load(json_file)
        return changed_files

def write_json_to_file(file:str, data: bool):
    print(f"file: {file}")
    with open(file, 'w') as outfile:
        json.dump(data, outfile)

def main():
    source_path = os.getenv("CODEBUILD_SRC_DIR")
    print(f"source_path: {source_path}")
    git_diff_file = os.getenv("OUTPUT_FILENAME")
    print(f"git_diff_file: {git_diff_file}")
    changed_files = get_json_from_file(git_diff_file)

    context_files = os.getenv("CONTEXT_FILE_LIST")
    context_files_updated = bool(set(changed_files).intersection(context_files))

    write_json_to_file(source_path + "rebuild_task.json", context_files_updated)

main()
