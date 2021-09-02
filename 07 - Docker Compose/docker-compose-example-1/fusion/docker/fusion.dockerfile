FROM python:3.9.0-alpine
LABEL maintainer "Geek University <contato@geekuniversity.com.br>"
COPY . /var/www
WORKDIR /var/www
RUN apk update && apk add zlib-dev jpeg-dev gcc musl-dev python3-dev postgresql-dev && pip install -r requirements.txt && python manage.py collectstatic --noinput
ENTRYPOINT gunicorn --bind 0.0.0.0:8000 fusion.wsgi
EXPOSE 8000
