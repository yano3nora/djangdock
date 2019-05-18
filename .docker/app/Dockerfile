FROM python:3.7
ENV  PYTHONUNBUFFERED 1

# Set up project root.
RUN     mkdir app
WORKDIR /app
COPY    . /app

# Install packages.
RUN pip install -r requirements.txt

# Run application server.
CMD uwsgi --ini /app/.docker/app/django.ini
