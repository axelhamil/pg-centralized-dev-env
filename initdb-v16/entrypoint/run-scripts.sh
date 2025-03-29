#!/bin/bash
set -e

until pg_isready -h ${POSTGRES_HOST:-localhost} -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL to start..."
  sleep 1
done

echo "PostgreSQL is up, executing SQL scripts..."

export PGPASSWORD="$POSTGRES_PASSWORD"

psql -h ${POSTGRES_HOST:-localhost} -U "$POSTGRES_USER" -f /docker-entrypoint-initdb.d/create_databases_v16.sql

echo "SQL scripts executed successfully."
