set -e
echo "INICIA CONFIGURACIÓN"
# Ejecutar el script de inicialización original de PostgreSQL
if [ -s "$PGDATA/PG_VERSION" ]; then
  echo "PostgreSQL cluster already exists. Skipping initialization."
  /usr/local/bin/docker-entrypoint.sh postgres
else
  echo "Initializing PostgreSQL cluster..."
  #ls -la /var/lib/postgresql/data
  /usr/local/bin/docker-entrypoint.sh postgres &
fi
echo "Cargando configuración inicial"
sleep 10
echo "Termina configuración de postgresql"
# 1. Crea al nuevo usuario
echo "Creando nuevo usuario"
psql -U postgres -c "CREATE USER $SIE_POSTGRES_USER  WITH LOGIN CREATEDB PASSWORD '$SIE_POSTGRES_USER_PASSWORD';"
# 2. Crea la base de datos
echo "Creando nueva base de datos"
psql -U $SIE_POSTGRES_USER -d postgres -c "CREATE DATABASE $SIE_POSTGRES_DATABASE;"
# 3. Hacer el backup la nueva db
echo "Realizando el backup"
psql -U $SIE_POSTGRES_USER -d $SIE_POSTGRES_DATABASE < /usr/local/bin/sie_backup.sql
echo "Finaliza Configuración"
wait
