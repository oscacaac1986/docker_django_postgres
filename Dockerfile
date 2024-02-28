FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y make

WORKDIR app/

COPY requirement.txt /app/

RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip && pip install -r requirement.txt

COPY . /app/

COPY entrypoint.sh /app/

CMD chmod +x entrypoint.sh






