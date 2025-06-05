FROM pandoc/core

RUN apk add --no-cache git

COPY ./convertirMdDocx.sh /app/convertirMdDocx.sh
COPY ./reference.docx /app/reference.docx
COPY ./filters.lua /app/filters.lua
RUN chmod +x /app/convertirMdDocx.sh
RUN chmod +x /app/reference.docx
RUN chmod +x /app/filters.lua
RUN chmod +x /app

ENTRYPOINT [ "sh" ]
CMD [ "/app/convertirMdDocx.sh" ]