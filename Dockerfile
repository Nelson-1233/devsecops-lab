FROM python:3.11-slim

WORKDIR /app

# Actualizar paquetes del sistema y eliminar caché
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario no privilegiado
RUN useradd -m appuser

COPY app/ /app/

RUN pip install --no-cache-dir -r requirements.txt

USER appuser

HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/buscar')" || exit 1

EXPOSE 8080

CMD ["python", "app.py"]