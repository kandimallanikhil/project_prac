#!/bin/bash

# Path to your policy file
policy_file="/root/custom-policy.json"

# Create the policy and capture the ARN from the response
policy_arn=$(aws iam create-policy --policy-name nikhil --policy-document file://$policy_file --query "Policy.Arn" --output text)

# Check if the policy was created successfully
if [ "$policy_arn" == "None" ]; then
  echo "Failed to create policy. Exiting."
  exit 1
else
  echo "Policy created successfully: $policy_arn"
fi

# Loop through a list of usernames (assuming usernames.txt contains a list of usernames)
for username in $(cat username.txt); do
    # Create the IAM user
    aws iam create-user --user-name $username
    echo "Created user: $username"

    # Attach the custom policy to the user
    aws iam attach-user-policy --user-name $username --policy-arn $policy_arn
    echo "Attached policy to user: $username"
done
