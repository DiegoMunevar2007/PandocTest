FROM pandoc/core

# Instalar dependencias 
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-cffi \
    cairo \
    pango \
    gdk-pixbuf \
    libffi \
    git

# Crear un entorno virtual para Python
RUN python3 -m venv /venv

# Activar el entorno virtual y luego instalar WeasyPrint
RUN /venv/bin/pip install weasyprint

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