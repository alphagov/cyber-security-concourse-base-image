#!/bin/bash
# Use Github REST API to get list of changed files from most recent Pull request

# Usage:
#  export GITHUB_PAT=[token]
#  export GITHUB_ORG=[orgname]
# get_pr_changed_files_list.sh [repo_name] [output_filename]

github_org=$GITHUB_ORG
repo_name=$1
output_file=$2


function call_github_api() {
	path=$1
	page=$2
  output_file=$3
  url="https://api.github.com${path}" #"?page=${page}"
  accept="application/vnd.github.v3+json"
	output=$(curl -H "Authorization: token ${GITHUB_PAT}" -H "Accept: ${accept}" ${url} -o ${output_file})
  echo $output
}

if [[ $repo_name == "-h" ]]; then
    cat <<EOM
		Usage: github_rest_get_pr_changed_files_list.sh [repo_name] [output_file_path]
		 eg  - export GITHUB_PAT=$(lpass show GitHub_PAT)
     github_rest_get_pr_changed_files_list.sh cyber-security-authenticate /opt/changed_files.json
		Requires jq - brew install jq
EOM
		exit
else
    call_github_api "/repos/${github_org}/${repo_name}/pulls?state=closed" 1 "closed_pulls.json"
    echo "Get latest merged PR into main/master branch"
    latest_pull=$(jq '[.[] | select(.merged_at != null) | select(.base.ref == "main" or .base.ref == "master")][0] | .number' closed_pulls.json)
    echo "Get list of changed file for PR: $latest_pull"
    call_github_api "/repos/${github_org}/${repo_name}/pulls/${latest_pull}/files" 1 "changed_files.json"
    files=$(jq '[.[] | .filename]' "changed_files.json")
    echo "Changed files for $repo_name PR:$latest_pull"
    echo $files > $output_file
    echo $files
fi
