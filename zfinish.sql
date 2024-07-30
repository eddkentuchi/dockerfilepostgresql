\c template1;
ALTER DATABASE postgres RENAME TO sie;
\c sie;
GRANT ALL PRIVILEGES ON DATABASE sie TO planeacion;

SELECT pg_reload_conf();
