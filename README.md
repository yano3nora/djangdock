djangdock.
===============

> posted: 2019.05.18  
> author: hyano@ampware.jp

## OVERVIEW
The Docker boilerplate for Django.

### Composition.
- nginx 1.15.6
- postgres 11
- python 3.7

### Containers.
```
[db]
  /var
    /lib
      /postgresql
        /data
[app]
  /app
    /static
    /django
      /app1
      /app2
      /app3
[web]
  /.credentials
  /var/log/nginx
  /etc
    /nginx
      /conf.d
        default.conf
      /uwsgi_params
  /static
```



------


## BUILD
> In the first time of build.

```sh
# Set up env.
$ cp .env.development .env
$ vi .env

# Install django.
$ docker-compose run --rm app django-admin startproject django .
# If building onto Linux, execute this.
$ sudo chown -R $USER:$USER .

# Fix settings.
$ vi django/settings.py
> import os
> ...
> DATABASES = {
>   'default': {
>     'ENGINE': 'django.db.backends.postgresql_psycopg2',
>     'NAME': os.environ['POSTGRES_USER'],
>     'USER': os.environ['POSTGRES_USER'],
>     'PASSWORD': os.environ['POSTGRES_PASSWORD'],
>     'HOST': os.environ['DATABASE_HOST'],
>     'PORT': os.environ['DATABASE_PORT'],
>     'OPTIONS': {
>       'charset': 'utf8mb4',
>     },
>   }
> }

# Build containers.
$ docker-compose build

# Create databases.
$ docker-compose run --rm app ./manage.py makemigrations
$ docker-compose run --rm app ./manage.py migrate

# Deploy containers.
$ docker-compose up -d
```
