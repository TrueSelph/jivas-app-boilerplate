.PHONY: all build up up-all down down-all restart restart-all stop stop-all init-agents import-agent clean-db destroy logs restart-client help

# Default target
all: build up-all

# Build the Docker images
build:
	@echo "Building Jivas services..."
	docker compose build

# Start the containers in detached mode
up:
	@echo "Starting Jivas services..."
	docker compose up -d

# Start the containers with optional services
up-all:
	@echo "Starting all Jivas services including optional ones..."
	docker compose -f docker-compose.yml -f docker-compose.optional.yml up -d

# Stop and remove containers
down:
	@echo "Stopping Jivas services..."
	docker compose down

# Stop and remove all containers including optional ones
down-all:
	@echo "Stopping all Jivas services including optional ones..."
	docker compose -f docker-compose.yml -f docker-compose.optional.yml down

# Restart services
restart:
	@echo "Restarting Jivas services..."
	docker compose restart

# Restart all services including optional ones
restart-all:
	@echo "Restarting all Jivas services including optional ones..."
	docker compose -f docker-compose.yml -f docker-compose.optional.yml restart

# Stop services without removing containers
stop:
	@echo "Stopping Jivas services..."
	docker compose stop

# Stop all services including optional ones without removing containers
stop-all:
	@echo "Stopping all Jivas services including optional ones..."
	docker compose -f docker-compose.yml -f docker-compose.optional.yml stop

# Initialize all agents
init-agents:
	@echo "Initializing all agents..."
	docker compose exec -it jivas bash -c "jvcli initagents"
	@echo "Agents initialized."

# Import a specific agent
import-agent:
	docker compose exec -it jivas bash -c "jvcli importagent $(AGENT)"

# Clean MongoDB data
clean-db:
	@echo "Cleaning MongoDB database..."
	docker exec -it mongodb mongosh --eval "db.dropDatabase()"
	@make restart

# Completely destroy all containers and volumes
destroy:
	@echo "Destroying all services and data..."
	docker compose down -v

# View logs for all services or a specific service
logs:
	@echo "Showing logs for Jivas services..."
ifdef SERVICE
	docker compose logs -f $(SERVICE)
else
	docker compose logs -f
endif

# Re-start the Jivas client
restart-client:
	docker compose exec -it jivas bash -c "supervisorctl restart jvclient"

# Help command
help:
	@echo "Available commands:"
	@echo "  make all         - Build and start Jivas services"
	@echo "  make build       - Build Docker images"
	@echo "  make up          - Start Jivas services"
	@echo "  make up-all      - Start all services including optional ones"
	@echo "  make down        - Stop and remove containers"
	@echo "  make down-all    - Stop and remove all containers including optional ones"
	@echo "  make restart     - Restart services"
	@echo "  make restart-all - Restart all services including optional ones"
	@echo "  make stop        - Stop services"
	@echo "  make stop-all    - Stop all services including optional ones"
	@echo "  make init-agents - Initialize all agents"
	@echo "  make import-agent [AGENT=jivas/name] - Import an agent"
	@echo "  make clean-db    - Clean MongoDB database"
	@echo "  make destroy     - Destroy all services and data"
	@echo "  make logs [SERVICE=name] - View logs for all or specific service"
	@echo "  make restart-client - Restart the Jivas client"
	@echo "  make help        - Show this help message"