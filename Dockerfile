FROM python:3.7-alpine
MAINTAINER Crisheld
# PYTHONUNBUFFERED hace que los outputs de python no sean bufferiados
# lo que evita algunos riesgos, recomendado para docker
ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers postgresql-dev postgresql-libs python3-dev

RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
