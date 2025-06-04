## Conversor de Markdown a Docx con Pandoc en Docker
Esto solo es una prueba para convertir archivos Markdown a Docx utilizando Pandoc dentro de un contenedor Docker. (Para no tener que instalar Pandoc).

#### Build del container
`docker build -t pandoc-converter .`	

#### Correr el container
`docker run --rm -v "$(pwd)/ProyectosMd:/app/ProyectosMd" -v "$(pwd)/ProyectosDocx:/app/ProyectosDocx" -w /app pandoc-converter`
#### Desglose del comando
- `--rm`: Elimina el contenedor después de que se detiene.
- `-v "$(pwd)/ProyectosMd:/app/ProyectosMd"`: Monta el directorio `ProyectosMd` del host al contenedor.
- `-v "$(pwd)/ProyectosDocx:/app/ProyectosDocx"`: Monta el directorio `ProyectosDocx` del host al contenedor.
- `-w /app`: Establece el directorio de trabajo dentro del contenedor a `/app`.
- `pandoc-converter`: Nombre de la imagen del contenedor que se ejecuta.