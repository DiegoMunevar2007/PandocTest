ls /app
cd /app/ProyectosMd

# Encontrar todos los archivos .md en ProyectosMd (Puede ser reemplazado por otro directorio en el cd)
find . -type f -name "*.md" | while read file; do
    # Obtener el directorio del archivo .md
    dirArchivoMd=$(dirname "$file")
    # Replicar la estructura de directorios correspondiente en ProyectosDocx
    mkdir -p "/app/ProyectosDocx/$dirArchivoMd"
    echo "Procesando archivo: $file"
    # Convertir el archivo .md a .docx
    pandoc "$file" -o "/app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.docx")" --reference-doc=/app/reference.docx
    echo "-> Convertido: $file -> /app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.docx")"
done

echo "Terminé :)"

# TODO: Hacer un archivo reference.docx con los estilos que se quieren aplicar a los archivos .docx para los proyectos