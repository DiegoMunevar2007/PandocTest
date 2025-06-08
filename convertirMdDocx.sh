ls /app
cd /app/ProyectosMd

# Encontrar todos los archivos .md en ProyectosMd (Puede ser reemplazado por otro directorio en el cd)
find . -type f -name "*.md" | while read file; do
    # Obtener el directorio del archivo .md
    dirArchivoMd=$(dirname "$file")
    # Replicar la estructura de directorios correspondiente en ProyectosDocx
    mkdir -p "/app/ProyectosDocx/$dirArchivoMd"
    echo "Procesando archivo: $file"

    # Crear un archivo de markdown extendido de pandoc 
    pandoc "$file" -f markdown -t markdown -o "temp.md"

    # Convertir el archivo .md a .docx
    # Tiene un filtro de lua que encontré para los highlights usando ==cosa== jeje - Diego 
    # https://github.com/jgm/pandoc/issues/8099
    pandoc "temp.md" -o "/app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.docx")" --reference-doc=/app/reference.docx --lua-filter=/app/filters.lua --from=markdown+rebase_relative_paths
    echo "-> Convertido: $file -> /app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.docx")"
    echo $file
    pandoc "/app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.docx")" -f docx -t pdf -o "/app/ProyectosDocx/$dirArchivoMd/$(basename "${file%.md}.pdf")" --pdf-engine="weasyprint" 
    # Eliminar el archivo temporal
    rm "/app/ProyectosMd/$dirArchivoMd/temp.md"

done

echo "Terminé :)"

# TODO: Hacer un archivo reference.docx con los estilos que se quieren aplicar a los archivos .docx para los proyectos