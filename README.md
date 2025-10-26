# Prática Curso Udemy: DBT – Pipelines de Engenharia de Dados

### Visão Geral

O objetivo principal é aprimorar a prática da ferramenta, criando um ambiente local robusto, onde é possível:

- Migrar dados de um banco DuckDB (Northwind) para Postgres.
- Preparar o ambiente para rodar dbt e explorar modelos de transformação de dados.
- Ter controle total sobre o ambiente, garantindo aprendizado prático sem depender de serviços em nuvem.

---
### Estrutura do Projeto

````` 
dbt_docker_lab/
│
├── dbt_lab/                   
│   ├── load_duckdb_to_postgres.py  # Script Python para migrar dados DuckDB -> Postgres
│   ├── requirements.txt            # Dependências Python
│   └── profiles.yaml                # Configuração dbt local
│   └── northwind/
│          └── data/
|             └── northwind.ddb # Banco DuckDB com dados de exemplo
└── docker-compose.yaml         # Containers: Postgres, pgAdmin, Redis
`````
---

### Ambiente Local

Para prática otimizada, o ambiente utiliza Docker para rodar os seguintes serviços:

````
 -----------------------------------------------------------------------------------------
|   Serviço	   |    Imagem / Versão	        |     Porta Local	Observações               |
|-----------------------------------------------------------------------------------------|
|   Postgres   |  postgres:13	5432	    |         Banco de dados principal            |
|   pgAdmin	   |   dpage/pgadmin4	8888	|         Interface para inspeção de tabelas  |
|   Redis	   |   redis:latest	6379	    |         Serviço auxiliar (opcional)         |
 -----------------------------------------------------------------------------------------
````

#### Comandos essenciais

- Subir os containers:

    `` docker compose up -d ``

- Parar e remover volumes (para reiniciar do zero):

    ``docker compose down --volumes --remove-orphans``

### Migração dos Dados DuckDB → Postgres

Os dados do Northwind (northwind.ddb) foram carregados no Postgres via Python, utilizando DuckDB, pandas e SQLAlchemy.

- Instalar dependências
    ``pip install -r dbt_lab/requirements.txt``

- Rodar script de migração
    ``python dbt_lab/load_duckdb_to_postgres.py``

###### O script realiza:

- Conexão com o DuckDB local.
- Extração de todas as tabelas.
- Inserção no banco Postgres no container Docker.
- Log detalhado do número de registros carregados por tabela e tempo de execução.

---
### Acesso ao Banco
````
pgAdmin: http://localhost:8888
Email: admin@admin.com
Senha: admin
Postgres: localhost:5432
Banco: dbt_container
Usuário: dbt_container
Senha: dbt_container
````
No pgAdmin, adicione um novo servidor apontando para dbt_container para acessar as tabelas migradas.

---

### Configuração do dbt

- Perfil dbt (profiles.yml) localizado em dbt_lab/:

````
    dbt_docker_lab:
    target: dev
    outputs:
        dev:
        type: postgres
        host: localhost
        user: dbt_container
        password: dbt_container
        port: 5432
        dbname: dbt_container
        schema: public
````

Com isso, é possível executar:

````
dbt debug      # Testa conexão com o banco
dbt run        # Executa modelos SQL
dbt test       # Testa integridade de dados
dbt docs generate  # Gera documentação dos pipelines
````
