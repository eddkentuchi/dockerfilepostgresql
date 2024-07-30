FROM arm64v8/postgres:15

# Eliminar el contenido del directorio de datos antes de iniciar
RUN rm -rf /var/lib/postgresql/data/*
# Copiar archivo de backup
COPY sie_backup.sql /docker-entrypoint-initdb.d/
# Copiar el script de creación de base de datos
COPY init.sql /docker-entrypoint-initdb.d/
#Copiar el cambio de nombre de la base de datos
COPY zfinish.sql /docker-entrypoint-initdb.d/
#Copiar script bash
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
# Exponer el puerto 5432
EXPOSE 5432
#Ejecutar script de inicio
CMD ["/usr/local/bin/entrypoint.sh"]
