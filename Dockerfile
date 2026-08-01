# CORRECCIÓN CONTENEDOR: Imagen base moderna
FROM python:3.11-slim

WORKDIR /app

# Crear usuario no privilegiado
RUN useradd -m appuser

COPY app/ /app/

RUN pip install --no-cache-dir -r requirements.txt

# Ejecutar como usuario no-root
USER appuser

EXPOSE 8080

CMD ["python", "app.py"]
