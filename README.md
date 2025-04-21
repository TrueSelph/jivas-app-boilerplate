# JIVAS Application Boilerplate

Welcome to your JIVAS AI project boilerplate! This guide provides detailed instructions for setting up and managing your JIVAS environment using Docker and Docker Compose.

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic knowledge of Docker container management
- Git (for cloning this repository)

## Project Structure

This boilerplate includes:
- Core Docker services (JIVAS, MongoDB)
- Optional services (Typesense, WPPConnect)
- Makefile with convenient commands
- Configuration files for your JIVAS environment

## Getting Started with Docker Compose

### Option 1: Using Docker Compose Commands

#### 1. Start Core Services Only

```sh
# Build and start the core services (JIVAS and MongoDB)
docker compose up -d
```

#### 2. Start All Services (Including Optional Ones)

```sh
# Build and start all services (including Typesense and WPPConnect)
docker compose -f docker-compose.yml -f docker-compose.optional.yml up -d
```

#### 3. Stopping the Services

```sh
# Stop core services
docker compose down

# Stop all services (including optional ones)
docker compose -f docker-compose.yml -f docker-compose.optional.yml down
```

### Option 2: Using the Makefile (Recommended)

The Makefile provides convenient shortcuts for common Docker operations.

#### 1. Start All Services

```sh
# Build and start all services (core + optional)
make all
```

#### 2. Start Core Services Only

```sh
# Start only the core services
make up
```

#### 3. Start All Services

```sh
# Start all services (including optional ones)
make up-all
```

#### 4. Stopping Services

```sh
# Stop core services
make down

# Stop all services (including optional ones)
make down-all
```

## Working with JIVAS Agents

### Initializing Agents

After starting your environment, initialize the agents:

```sh
# Using Docker Compose directly
docker compose exec -it jivas bash -c "jvcli initagents"

# Using Makefile
make init-agents
```

### Importing Specific Agents

```sh
# Using Docker Compose directly
docker compose exec -it jivas bash -c "jvcli importagent jivas/demo_ai"

# Using Makefile
make import-agent AGENT=jivas/demo_ai
```

### Accessing the JIVAS Manager

The JIVAS Manager is available at http://localhost:8501 after starting your services.

## Environment Management

### Service Status and Logs

```sh
# View logs for all services
make logs

# View logs for a specific service
make logs SERVICE=jivas
```

### Restarting Services

```sh
# Restart all core services
make restart

# Restart all services (including optional ones)
make restart-all

# Restart just the JIVAS client
make restart-client
```

### Cleaning and Resetting

```sh
# Clean the MongoDB database
make clean-db

# Completely destroy all containers and volumes (WARNING: Data loss)
make destroy
```

## Advanced Operations

### Build Images Only

```sh
make build
```

### Stop Without Removing

```sh
# Stop core services without removing containers
make stop

# Stop all services without removing containers
make stop-all
```

## Environment Variables

The project uses environment variables defined in the `.env` file. When logged into the JIVAS Manager, use the default credentials:

- Username: admin@jivas.com (or as defined in your .env file)
- Password: password (or as defined in your .env file)

## Available Make Commands

For a full list of available commands:

```sh
make help
```

This will display all available Makefile commands with descriptions.

## Troubleshooting

If you encounter issues:

1. Check container logs with `make logs SERVICE=<service-name>`
2. Ensure MongoDB has initialized properly
3. Try restarting services with `make restart-all`
4. For persistent problems, you may need to reset with `make destroy` and start again

Happy building with JIVAS!