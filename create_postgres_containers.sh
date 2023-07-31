#!/bin/bash

# Set the number of containers you want to create
NUM_CONTAINERS=2

# Set the base name for the containers
CONTAINER_BASE_NAME="student"

# Set the starting counter for usernames and passwords
STARTING_COUNTER=1

# Set the base password for the PostgreSQL containers
BASE_PASSWORD="student"

# Set the starting port number for the containers
STARTING_PORT=5432

# Output file name
OUTPUT_FILE="postgres_containers.csv"

# Create an empty output file with headers
echo "Container Name,Host Port,Internal IP,External IP,Username,Password" > "$OUTPUT_FILE"

# Loop to create multiple PostgreSQL containers
for ((i=1; i<=NUM_CONTAINERS; i++)); do
    # Generate a unique container name
    CONTAINER_NAME="${CONTAINER_BASE_NAME}-${i}"

    # Calculate the host machine port for the current container
    HOST_PORT=$((STARTING_PORT + i - 1))

    # Generate incremental username and password
    USERNAME="${CONTAINER_BASE_NAME}${STARTING_COUNTER}"
    PASSWORD="${BASE_PASSWORD}${STARTING_COUNTER}"

    # Create the PostgreSQL container with environment variables for username and password
    docker run -d \
        --name "$CONTAINER_NAME" \
        --restart=unless-stopped \
        -e POSTGRES_USER="$USERNAME" \
        -e POSTGRES_PASSWORD="$PASSWORD" \
        -p "$HOST_PORT:5432" \
        postgres

    # Get the container internal IP address
    INTERNAL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_NAME")

    # Get the external IP address from a public IP API service
    EXTERNAL_IP=$(curl -s https://api.ipify.org)

    echo "Created container: $CONTAINER_NAME - Host Port: $HOST_PORT"
    echo "  Username: $USERNAME"
    echo "  Password: $PASSWORD"
    echo "  Internal IP Address: $INTERNAL_IP"
    echo "  External IP Address: $EXTERNAL_IP"

    # Append the container details to the output file
    echo "$CONTAINER_NAME,$HOST_PORT,$INTERNAL_IP,$EXTERNAL_IP,$USERNAME,$PASSWORD" >> "$OUTPUT_FILE"

    # Increment the counter for the next container
    STARTING_COUNTER=$((STARTING_COUNTER + 1))
done
