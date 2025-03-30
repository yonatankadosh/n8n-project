# n8n Project

Docker-based n8n setup with SQLite database integration and automated backups.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for version control)
- At least 2GB of free RAM
- At least 5GB of free disk space

## Project Structure

```
n8n-project/
├── docker-compose.yml    # Docker configuration
├── backups/             # Automated backups directory
│   ├── workflows/       # Workflow exports
│   └── database/        # Database backups
└── scripts/
    └── backup.sh        # Backup script
```

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/yonatankadosh/n8n-project.git
   cd n8n-project
   ```

2. Start n8n:
   ```bash
   docker-compose up -d
   ```

3. Wait about 30 seconds for the services to initialize

4. Access n8n:
   - Open your browser and navigate to: http://localhost:5679
   - You'll be prompted to create an owner account on first run

## Configuration

The default configuration in `docker-compose.yml` includes:
- n8n running on port 5679
- SQLite database for data persistence
- Data stored in `/Users/who/.n8n` directory

## Automated Backups

The project includes an automated backup system that:
- Backs up the SQLite database
- Exports all workflows
- Creates dated archives
- Commits backups to Git

To manually run a backup:
```bash
./scripts/backup.sh
```

Automated backups are scheduled to run daily at midnight.

## Stopping the Service

To stop n8n:
```bash
docker-compose down
```

To stop and remove all data (including database):
```bash
docker-compose down -v
```

## Troubleshooting

1. If n8n is not accessible:
   - Check if containers are running: `docker ps`
   - View n8n logs: `docker-compose logs n8n`
   - Ensure port 5679 is not in use by another service

2. If you can't access the database:
   - Check SQLite file permissions
   - Verify the container has write access to the .n8n directory

3. Common issues:
   - Permission errors: Ensure the .n8n directory is owned by the correct user
   - Port conflicts: Change the port in docker-compose.yml if 5679 is in use
   - Memory issues: Ensure your system has enough free RAM

## Maintenance

1. Update n8n:
   ```bash
   docker-compose pull
   docker-compose up -d
   ```

2. View logs:
   ```bash
   docker-compose logs -f n8n
   ```

3. Backup data:
   ```bash
   ./scripts/backup.sh
   ```

## Security Notes

- Change default passwords immediately after setup
- Keep your Docker and n8n versions updated
- Regularly backup your data
- Don't expose n8n directly to the internet without proper security measures

## Support

For issues specific to this setup, please create an issue in the GitHub repository.

For n8n-specific questions, refer to:
- [n8n Documentation](https://docs.n8n.io/)
- [n8n Community Forum](https://community.n8n.io/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
