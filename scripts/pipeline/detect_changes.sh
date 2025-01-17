#!/usr/bin/env bash

enviroments=("devl" "nle" "live")
envs_folder="./terraform/envs"

for env in "$(environments[@])"; do
  folder_path="$envs_folder/$env/"

  # check for changed files within the current env dir
  if git diff --quiet HEAD~1 -- "$folder_path"; then
    continue
  fi
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
