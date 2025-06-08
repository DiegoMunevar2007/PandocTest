FROM pandoc/core

# Instalar dependencias 
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-weasyprint \
    git

# Cambiar a directorio app
WORKDIR /app

# Copiar archivos necesarios al contenedor
COPY ./convertirMdDocx.sh /app/convertirMdDocx.sh
COPY ./reference.docx /app/reference.docx
COPY ./filters.lua /app/filters.lua

# Dar permisos de ejecución al script
RUN chmod +x /app/convertirMdDocx.sh

# Correr el script al iniciar el contenedor
ENTRYPOINT ["sh"]
CMD ["/app/convertirMdDocx.sh"]