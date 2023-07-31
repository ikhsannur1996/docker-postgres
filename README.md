# Docker PostgreSQL Containers Setup Script

This Bash script allows you to create multiple PostgreSQL containers with incremental usernames and passwords. It also retrieves the internal and external IP addresses of each container and saves the container details in a CSV file.

## Prerequisites

- Docker installed on your system.

## Getting Started

1. Clone or download the script file `create_postgres_containers.sh` from this repository.

2. Make sure the script has executable permissions:

   ```bash
   chmod +x create_postgres_containers.sh
   ```

3. Run the script to create the PostgreSQL containers:

   ```bash
   ./create_postgres_containers.sh
   ```

## Configuration

You can modify the following variables in the script to customize the setup:

- `NUM_CONTAINERS`: Set the number of PostgreSQL containers you want to create.

- `CONTAINER_BASE_NAME`: Set the base name for the PostgreSQL containers. The script will append numbers to this base name to generate unique container names.

- `STARTING_COUNTER`: Set the starting counter for generating incremental usernames and passwords.

- `BASE_PASSWORD`: Set the base password for the PostgreSQL containers. The script will append numbers to this base password to generate unique passwords for each container.

- `STARTING_PORT`: Set the starting port number for the containers. The script will increment the port number for each container.

## Output

After running the script, it will create the specified number of PostgreSQL containers with incremental usernames and passwords. The script will display the container details on the terminal, including the container name, host port, internal IP address, external IP address, username, and password. Additionally, all container details will be saved in the `postgres_containers.csv` file.

The CSV file will have the following format:

```
Container Name,Host Port,Internal IP,External IP,Username,Password
student-1,5432,172.17.0.2,203.0.113.1,student1,student1
student-2,5433,172.17.0.3,203.0.113.1,student2,student2
```

Note: The external IP address may change if your network has a dynamic IP. If you require a static IP address, consider using a service that provides static IP allocation for Docker containers.

## Cleanup

To stop and remove all the PostgreSQL containers created by this script, you can use the following commands:

```bash
docker stop $(docker ps -aqf "name=student-")
docker rm $(docker ps -aqf "name=student-")
```

Remember to adjust the container name pattern if you have modified the `CONTAINER_BASE_NAME`.

---

Feel free to modify the README.md file according to your specific requirements, and don't forget to add any additional details or usage instructions you think might be helpful for users.
