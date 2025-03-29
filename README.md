# PostgreSQL Multi-Database Container

A single PostgreSQL container configured to host multiple databases for different projects, avoiding the need to run one container per project.

## Configuration

1. Copy `.env.example` to `.env` and modify the values as needed

   ```
   cp .env.example .env
   ```

2. To add a new database for a project, follow these steps:

   - Add environment variables in `.env`

   ```
   # Project: your-project-name
   YOUR_PROJECT_DB_NAME=your_project_db
   YOUR_PROJECT_DB_USER=your_project_user
   YOUR_PROJECT_DB_PASSWORD=your-project-password
   ```

   - Add these variables in the `environment` block of `docker-compose.yaml`

   ```yaml
   environment:
     # Existing variables...
     YOUR_PROJECT_DB_NAME: ${YOUR_PROJECT_DB_NAME}
     YOUR_PROJECT_DB_USER: ${YOUR_PROJECT_DB_USER}
     YOUR_PROJECT_DB_PASSWORD: ${YOUR_PROJECT_DB_PASSWORD}
   ```

   - Duplicate the code block in `initdb-v16/create_databases_v16.sql` and adjust the variables

3. Start the PostgreSQL container

   ```
   docker-compose up -d
   ```

## Connection

- **Host:** localhost
- **Port:** 5436
- **User:** Project dependent (defined in `.env`)
- **Password:** Project dependent (defined in `.env`)
- **Database:** Project dependent (defined in `.env`)

## Security

⚠️ **Warning:** The `.env` files contain sensitive information and should not be committed to the Git repository. A `.gitignore` file is configured to prevent this.

## File Structure

- `docker-compose.yaml` - PostgreSQL container configuration
- `initdb-v16/` - Initialization scripts for PostgreSQL v16
  - `create_databases_v16.sql` - SQL script to create databases and users
  - `init-v16.sh` - Shell initialization script
  - `entrypoint/run-scripts.sh` - Shell script to execute SQL scripts
