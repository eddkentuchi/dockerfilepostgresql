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
echo "Cargando configuración inicial"
sleep 10
#echo "Termina configuración de postgresql"
# 1. Crear la base de datos 'sie'
psql -U postgres -c "CREATE USER $POSTGRES_USER  WITH LOGIN CREATEDB PASSWORD '$POSTGRES_USER_PASSWORD';"
psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE $POSTGRES_DATABASE;"
echo "Se creo la base de datos sie"
# 2. Hacer el backup en sie mediante users
pg_dump -U usertosie -d postgres -Fc sieusers > /usr/local/bin/sie_backup.sql
echo "Finaliza Configuración"
fi
wait
