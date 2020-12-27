#!/usr/bin/env bash

# Configure, build and run ShellCheck shell script linter over all scripts in project directory

set -euo pipefail

PROJECT_DIR=$(
  cd "$(dirname "$0")"/../..
  pwd
)

cd "${PROJECT_DIR}"

git ls-files | while read -r file
do
  if [[ -f "$file" && -x "$file" && "$(head --lines 1 "$file")" == "#!/usr/bin/env bash" ]]
  then
    shellcheck \
        --check-sourced \
        --color=always \
        --external-sources \
        --severity=info \
        --shell=bash \
        "$file"
    printf "OK: %s\n" "$file"
  fi
done

echo shellcheck success
