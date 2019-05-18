FROM python:3.7
ENV  PYTHONUNBUFFERED 1

# Set up project root.
RUN     mkdir app
WORKDIR /app

# Install packages before copy sources, for building cache.
COPY ./.docker/app/requirements.txt /app/.docker/app/requirements.txt
RUN  pip install -r /app/.docker/app/requirements.txt

# Copy source codes.
COPY . /app

# Run application server.
CMD uwsgi --ini /app/.docker/app/django.ini
