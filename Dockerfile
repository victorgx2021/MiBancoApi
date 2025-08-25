FROM python:3.11-slim

RUN pip install fastapi uvicorn

WORKDIR /app

COPY . .

EXPOSE 80

CMD ["python3", "miBanco.py"]
