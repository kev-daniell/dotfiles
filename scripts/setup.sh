#!/bin/bash

source .env
# Prompt and export environment variables
export HOSTNAME=$(hostname -s)

export USERNAME=$(whoami)

echo -e "\n✅ Environment variables set:"
echo "HOSTNAME=$HOSTNAME"
echo "USERNAME=$USERNAME"
echo "GIT_NAME=$GIT_NAME"
echo "GIT_EMAIL=$GIT_EMAIL"
echo "GPG_KEY_ID=$GPG_KEY_ID"
echo "GEMINI_KEY=$GEMINI_KEY"

# Function to recursively replace %VAR% in files under current directory
echo -e "\n🔧 Replacing variables in files under $(pwd)..."

for file in $(find . -type f); do
  # exclude setup.sh from replacement
  if file "$file" | grep -q text && [ "$(basename "$file")" != "setup.sh" ]; then
    sed -i '' "s|%HOSTNAME%|$HOSTNAME|g" "$file"
    sed -i '' "s|%USERNAME%|$USERNAME|g" "$file"
    sed -i '' "s|%GIT_NAME%|$GIT_NAME|g" "$file"
    sed -i '' "s|%GIT_EMAIL%|$GIT_EMAIL|g" "$file"
    sed -i '' "s|%GPG_KEY_ID%|$GPG_KEY_ID|g" "$file"
    sed -i '' "s|%GEMINI_KEY%|$GEMINI_KEY|g" "$file"
  fi
done

echo -e "\n✅ Replacement complete."
