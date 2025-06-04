FROM pandoc/core

RUN apk add --no-cache git

COPY ./convertirMdDocx.sh /app/convertirMdDocx.sh
COPY ./reference.docx /app/reference.docx
RUN chmod +x /app/convertirMdDocx.sh
RUN chmod +x /app/reference.docx

ENTRYPOINT [ "sh" ]
CMD [ "/app/convertirMdDocx.sh" ]