djangdock.
===============

> posted: 2019.05.18  
> author: hyano@ampware.jp

## OVERVIEW
The Docker boilerplate for Django x Nginx x PostgreSQL x Redis.

### Composition.
- nginx 1.15.6
- postgres 11
- redis 5.0.3
- python 3.7

### Containers.
```
[redis]
  /data
[db]
  /var
    /lib
      /postgresql
        /data
[app]
  /app
    /static
    /djangdock
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
$ docker-compose run --rm app django-admin startproject djangdock .
# If building onto Linux, execute this.
$ sudo chown -R $USER:$USER .

# Fix settings.
$ vi djangdock/settings.py
> import os
> import dj_database_url
> 
> SECRET_KEY = os.environ['SECRET_KEY']
> DEBUG = eval(os.environ['DEBUG'])
> ALLOWED_HOSTS = [os.environ['DOMAIN']]
> DATABASES = {
>     'default': dj_database_url.parse(os.environ['DATABASE_URL'], conn_max_age=600)
> }
> TIME_ZONE = os.environ['TZ']
> STATIC_URL = '/static/'
> STATIC_ROOT = '/static'

# Build containers.
$ docker-compose build

# Create databases.
$ docker-compose run --rm app ./manage.py makemigrations
$ docker-compose run --rm app ./manage.py migrate

# Deploy containers.
$ docker-compose up -d
```


------


## Deployment
```
$ docker-compose up     # Attach mode.
$ docker-compose up -d  # Detach mode.

# Accessing to docker-machine IP via 80 or 443 port by your browser.
# Retry after one moment please if you received 5xx response.
```

### Commands
```
# Launch bash.
$ docker-compose exec app bash

# Shutdown containers.
$ docker-compose down

# Re-setup Database.

# Clear log / cache.

# Add Packages.
$ vi .docker/app/requirements.txt
$ docker-compose build
```
