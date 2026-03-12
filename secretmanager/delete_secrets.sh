#!/bin/bash

# Test for correct number of arguments
if test "$#" -ne 1; then
    echo "Illegal number of parameters, exiting."
    exit 1
fi

# Set your Google Cloud project ID
PROJECT_ID=$1

# Check if the project exists and is accessible
# We use 'gcloud projects describe' and redirect stderr to /dev/null
# to suppress error messages if the project doesn't exist or is inaccessible.
# The '||' operator executes the second command if the first fails (returns non-zero exit code).
if ! gcloud projects describe "$PROJECT_ID" &> /dev/null; then
  echo "Error: Project '$PROJECT_ID' does not exist or you do not have permission to access it."
  echo "Please ensure the project ID is correct and your gcloud account has 'resourcemanager.projects.get' permission."
  exit 1 # Exit the script with an error code
fi

echo "Listing secrets in project: $PROJECT_ID"
echo "-------------------------------------"

# Retrieve all secret names in the specified project
# The --format="value(name)" ensures only the secret name is returned, one per line.
SECRETS=$(gcloud secrets list --project="$PROJECT_ID" --format="value(name)")

# Check if any secrets were found
if [ -z "$SECRETS" ]; then
  echo "No secrets found in project $PROJECT_ID."
  exit 0
fi

echo "Found the following secrets:"
echo "$SECRETS"
echo "-------------------------------------"

# Loop through each secret and prompt for deletion
for SECRET_NAME in $SECRETS; do
  # Extract just the secret ID from the full resource name
  SECRET_ID=$(basename "$SECRET_NAME")

  # Check if the secret name starts with 'sql-creds'
  if [[ "$SECRET_ID" == "sql-creds"* ]]; then
    echo "Skipping secret '$SECRET_ID' as its name starts with 'sql-creds'."
  else
    # This 'else' block contains the code that will ask for approval and delete
    # if the secret name does NOT start with 'sql-creds'.
    read -p "Do you want to delete secret '$SECRET_ID' in project '$PROJECT_ID'? (y/N): " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Deleting secret '$SECRET_ID'..."
      gcloud secrets delete "$SECRET_ID" --project="$PROJECT_ID" --quiet
      if [ $? -eq 0 ]; then
        echo "Secret '$SECRET_ID' deleted successfully."
      else
        echo "Failed to delete secret '$SECRET_ID'."
      fi
    else
      echo "Skipping deletion of secret '$SECRET_ID'."
    fi
  fi
  echo "-------------------------------------"
done
