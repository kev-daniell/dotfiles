#!/bin/bash

# Prompt and export environment variables
export HOSTNAME=$(hostname -s)

export USERNAME=$(whoami)

read -rp "Enter your name for git: " GIT_NAME
export GIT_NAME

read -rp "Enter your email for git: " GIT_EMAIL
export GIT_EMAIL

echo -e "\n✅ Environment variables set:"
echo "HOSTNAME=$HOSTNAME"
echo "USERNAME=$USERNAME"
echo "GIT_NAME=$GIT_NAME"
echo "GIT_EMAIL=$GIT_EMAIL"

# Function to recursively replace %VAR% in files under current directory
echo -e "\n🔧 Replacing variables in files under $(pwd)..."

for file in $(find . -type f); do
  # exclude setup.sh from replacement
  if file "$file" | grep -q text && [ "$(basename "$file")" != "setup.sh" ]; then
    sed -i '' "s|%HOSTNAME%|$HOSTNAME|g" "$file"
    sed -i '' "s|%USERNAME%|$USERNAME|g" "$file"
    sed -i '' "s|%GIT_NAME%|$GIT_NAME|g" "$file"
    sed -i '' "s|%GIT_EMAIL%|$GIT_EMAIL|g" "$file"
  fi
done

echo -e "\n✅ Replacement complete."
