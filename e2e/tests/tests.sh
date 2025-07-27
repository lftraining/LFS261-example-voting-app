#!/bin/sh

# Function to get current vote count
get_vote_count() {
    phantomjs render.js "http://result:80/" | grep -oE '[0-9]+' | head -n 1
}

# ... Later in script ...

if ! [ -z "$initial_count" ] && ! [ -z "$new" ] && [ "$initial_count" -lt "$new" ]; then
    echo -e "\e[42m------------"
    echo -e "\e[92mTests passed"
    echo -e "\e[42m------------"
    exit 0
else
    echo -e "\e[41m------------"
    echo -e "\e[91mTests failed"
    echo -e "\e[41m------------"
    echo "Expected: greater than $initial_count, Actual: $new"
    exit 1
fi


# Wait for services to be ready
echo "Waiting for services to be ready..."
while ! timeout 1 bash -c "echo > /dev/tcp/vote/80"; do
    sleep 1
done
echo "Vote service is ready."

while ! timeout 1 bash -c "echo > /dev/tcp/result/80"; do
    sleep 1
done
echo "Result service is ready."

# Get initial vote count
initial_count=$(get_vote_count)

echo "Initial vote count: $initial_count"



# Submit first vote
echo "Submitting vote (a)..."
curl -sS -X POST --data "vote=a" http://vote
sleep 2
current=$(get_vote_count)
echo "Vote count after first submission: $current"

# Calculate expected next count
# final=$((initial_count + 1))
# echo "Expected final count: $final"

# Check vote count multiple times
# for i in {1..5}; do
   # sleep 2
new=$(get_vote_count)
# done

# Final check
echo "Performing final check..."
if [ $initial_count -lt $new ]; then
    echo -e "\e[42m------------"
    echo -e "\e[92mTests passed"
    echo -e "\e[42m------------"
    exit 0
else
    echo -e "\e[41m------------"
    echo -e "\e[91mTests failed"
    echo -e "\e[41m------------"
    echo "Expected: $next, Actual: $new"
    exit 1
fi
