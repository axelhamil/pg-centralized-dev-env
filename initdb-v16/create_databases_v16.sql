------ You can add as many databases as needed by duplicating the following block for each project
--- PROJECT - ts-monorepo-boilerplate https://github.com/axelhamil/ts-monorepo-boilerplate/tree/main
SELECT format('CREATE DATABASE %I', :'TS_MONOREPO_DB_NAME')
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = :'TS_MONOREPO_DB_NAME')
\gexec

\c :TS_MONOREPO_DB_NAME

DO $$
DECLARE
    db_user TEXT := current_setting('TS_MONOREPO_DB_USER');
    db_password TEXT := current_setting('TS_MONOREPO_DB_PASSWORD');
    db_name TEXT := current_setting('TS_MONOREPO_DB_NAME');
BEGIN
    EXECUTE format('
        DO $inner$
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = %L) THEN
                CREATE USER %I WITH PASSWORD %L;
                
                -- Grant all necessary privileges
                GRANT ALL PRIVILEGES ON DATABASE %I TO %I;
                GRANT ALL ON SCHEMA public TO %I;
                ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO %I;
                ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO %I;
            END IF;
        END $inner$;',
        db_user, db_user, db_password, db_name, db_user, db_user, db_user, db_user
    );
END $$;
------