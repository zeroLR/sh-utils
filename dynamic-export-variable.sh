#!/bin/bash

# Export env variable of each string in a list with some condition

result=""

# Create a list of string
list="account user none"

# Loop through the list
for i in $list; do
    result=$(docker images --format "{{.Repository}}" | grep "$i")
    # If result is not empty
    if [ -n "$result" ]; then
        echo "$result"
        env_key="result_$i"
        export "$env_key"="$i"
    fi
done

# Print out the env variable, it will be empty if the result is empty
echo "$result_user"
echo "$result_account"
echo "$result_none"