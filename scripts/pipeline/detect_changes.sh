#!/usr/bin/env bash

environments=("devl" "nle" "live")
envs_folder="./terraform/envs"

default_branch="main"

merge_base=$(git merge-base HEAD origin/$default_branch)

for env in "${environments[@]}"; do
  folder_path="$envs_folder/$env"

  # check for changed files within the current env dir
  if git diff main -- $folder_path ; then
    continue
  fi
    echo "ENV_ENVIRONMENT_NAME"=$env >> $GITHUB_ENV
    echo "ENV_ENVIRONMENT_PATH"=$folder_path >> $GITHUB_ENV

    echo "::set-output name=env_environment_name::$env"
    echo "::set-output name=env_environment_path::$folder_path"

    echo "Changes detected in: $env ($folder_path)"
    exit 0
done

# output if no changes are detected
echo "No changes detected in any Environment"
exit 1
