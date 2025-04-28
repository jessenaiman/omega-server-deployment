# Server Deployment for AI Services

This project sets up a Docker-based environment for running three AI development platforms:

1. **AutoGen Studio** - A no-code platform for building multi-agent AI applications (https://autogen.localhost)
2. **Open WebUI** - A web interface for interacting with Ollama models (https://webui.localhost)
3. **All-Hands/OpenHands** - An AI system for software development (https://openhands.localhost)

## Architecture

The system uses:
- Docker and Docker Compose for containerization
- Nginx as a reverse proxy
- Self-signed SSL certificates for local development

## Prerequisites

- Docker and Docker Compose installed
- Git
- Basic knowledge of terminal commands

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/server-deployment.git
   cd server-deployment
   ```

2. Create an environment file from the example:
   ```bash
   cp .env.example .env
   ```

3. Edit the `.env` file with your actual API keys

4. Generate SSL certificates for local development:
   ```bash
   cd scripts
   ./generate_certificates.sh
   ```

5. Start the services:
   ```bash
   docker-compose up -d
   ```

6. Add entries to your hosts file for local domain resolution:
   ```
   127.0.0.1 autogen.localhost webui.localhost openhands.localhost
   ```

7. Access the services:
   - AutoGen Studio: https://autogen.localhost
   - Open WebUI: https://webui.localhost
   - All-Hands: https://openhands.localhost

## Testing

Use the provided test script to check if services are running properly:
```bash
./scripts/test_services.sh
```

You can also test individual services:
```bash
./scripts/test_services.sh autogen    # Test only AutoGen Studio
./scripts/test_services.sh open-webui # Test only Open WebUI
./scripts/test_services.sh all-hands  # Test only All-Hands
```

## Deployment to Production

For a production deployment with proper HTTPS:

1. Replace `localhost` domains with your actual domain names in Nginx configurations
2. Use a service like Let's Encrypt to generate valid SSL certificates
3. Update the WEBUI_URL environment variable in the docker-compose.yml

## Troubleshooting

If you encounter any issues:

1. Check the logs: `docker-compose logs -f [service-name]`
2. Ensure all ports are available
3. Verify your API keys are correctly set in the `.env` file
4. If you see browser security warnings, this is expected with self-signed certificates for local development