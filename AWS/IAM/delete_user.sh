#!/bin/bash

# List of usernames to delete (assuming usernames.txt contains the list of usernames)
for username in $(cat username.txt); do
    # Detach any policies attached to the user
    attached_policies=$(aws iam list-attached-user-policies --user-name $username --query 'AttachedPolicies[].PolicyArn' --output text)

    # Loop through and detach each policy from the user
    for policy in $attached_policies; do
        echo "Detaching policy $policy from user $username"
        aws iam detach-user-policy --user-name $username --policy-arn $policy
    done

    # Remove the user from any groups they are part of
    user_groups=$(aws iam list-groups-for-user --user-name $username --query 'Groups[].GroupName' --output text)
    for group in $user_groups; do
        echo "Removing user $username from group $group"
        aws iam remove-user-from-group --user-name $username --group-name $group
    done

    # Delete the user
    echo "Deleting user: $username"
    aws iam delete-user --user-name $username
    echo "Deleted user: $username"
done

