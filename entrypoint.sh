#!/bin/bash

python manage.py migrate

echo "Migraciones realizadas"

python manage.py createsuperuser --noinput || true

echo "Usuario admin creado."

echo "Script finalizado...."




