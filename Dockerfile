FROM pandoc/core

RUN apk add --no-cache git

COPY ./convertMdDocx.sh /app/convertMdDocx.sh
COPY ./reference.docx /app/reference.docx
RUN chmod +x /app/convertMdDocx.sh
RUN chmod +x /app/reference.docx

ENTRYPOINT [ "sh" ]
CMD [ "/app/convertMdDocx.sh" ]