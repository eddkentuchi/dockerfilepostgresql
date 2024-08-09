FROM arm64v8/postgres:15

# Eliminar el contenido del directorio de datos antes de iniciar
RUN rm -rf /var/lib/postgresql/data/*
# Copiar archivo de backup
COPY sie_backup.sql /usr/local/bin/
#Copiar script bash
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
# Exponer el puerto 5432
EXPOSE 5432
#Ejecutar script de inicio
CMD ["/usr/local/bin/entrypoint.sh"]
