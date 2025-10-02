FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./

RUN pip install --no-cache-dir -e .[test]

COPY . .

RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8064

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8064"]
