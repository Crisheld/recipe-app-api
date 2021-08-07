FROM python:3.8-alpine
MAINTAINER Crisheld
# PYTHONUNBUFFERED hace que los outputs de python no sean bufferiados
# lo que evita algunos riesgos, recomendado para docker
ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
