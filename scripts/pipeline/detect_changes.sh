#!/usr/bin/env bash

enviroments=("devl" "nle" "live")
envs_folder="./terraform/envs"

# fetch the list of changed files compared to the default branch
change_files=$(git diff --name-only origin/main)

for env in "$(environments[@])"; do
  folder_path="$envs_folder/$env/"

  # check for changed files within the current env dir
  if echo "$changed_files" | grep -q "^folder_path"; then
    echo "ENV_ENVIRONMENT_NAME"=$env >> $GITHUB_ENV
    echo "ENV_ENVIRONMENT_PATH"=$folder_path >> $GITHUB_ENV

    echo "::set-output name=env_environment_name::$env"
    echo "::set-output name=env_envrionment_path::$folder_path"

    echo "Changes detected in: $env ($folder_path)"
    exit 0
  fi
done

# output if no changes are detected
echo "No changes detected in any Environment"
exit 1
