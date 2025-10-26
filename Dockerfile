# Imagem base leve com Python 3.11
FROM python:3.11-slim

# Instala dependências do sistema e o dbt com adapter DuckDB
RUN apt-get update && apt-get install -y --no-install-recommends git && \
    pip install --no-cache-dir dbt-duckdb && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /usr/app

# Copia o conteúdo local pro container
COPY . .

# Comando padrão
CMD ["bash"]
