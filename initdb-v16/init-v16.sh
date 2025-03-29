#!/bin/bash
set -e

echo "Executing SQL scripts..."
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/create_databases_v16.sql

echo "SQL scripts executed successfully."
