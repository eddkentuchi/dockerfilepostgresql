set -e
echo "INICIA CONFIGURACIÓN"
echo "Esperando 10 segundos..."
sleep 2
# Ejecutar el script de inicialización original de PostgreSQL
if [ -s "$PGDATA/PG_VERSION" ]; then
  echo "PostgreSQL cluster already exists. Skipping initialization."
  rm -r /docker-entrypoint-initdb.d
  /usr/local/bin/docker-entrypoint.sh postgres 
else
  echo "Initializing PostgreSQL cluster..."
  #ls -la /var/lib/postgresql/data
  /usr/local/bin/docker-entrypoint.sh postgres 
fi
#echo "Termina configuración de postgresql"

  # Esperar a que PostgreSQL esté listo
  echo "Iniciando postgresql"
#until pg_isready -h localhost -p 5432 -U postgres; do
#  echo "Waiting for PostgreSQL to be ready..."
#  sleep  2 
#done
#fi
