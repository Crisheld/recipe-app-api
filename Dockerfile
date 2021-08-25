FROM python:3.7-alpine
MAINTAINER Crisheld
# PYTHONUNBUFFERED hace que los outputs de python no sean bufferiados
# lo que evita algunos riesgos, recomendado para docker
ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers postgresql-dev postgresql-libs python3-dev musl-dev zlib zlib-dev

RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user

RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user
