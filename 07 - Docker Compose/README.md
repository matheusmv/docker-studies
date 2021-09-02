# Docker Compose

Docker compose é uma ferramenta para definição e execução de múltiplos containers Docker - permite configurar todos
os parầmetros necessários para executar cada container a partir de um arquivo de definição. Com o Docker compose
podemos também especificar quais volumes e rede serão criados para serem utilizados nos parâmetros dos serviços.

O arquivo de definição do Docker Compose é o local onde é especificado todo o ambiente (rede, volume e serviços),
ele é escrito seguindo o formato YAML - por padrão tem como nome docker-compose.yml.

 - Comando de execução mais utilizados:

    - build: usada para construir todas as imagens dos serviços que estão descritos com a definição build em seu 
    bloco de código.
    
    - up: iniciar todos os serviços que estão no arquivo docker-compose.yml
    
    - stop: parar todos os serviços que estão no arquivo docker-compose.yml

    - ps: listar todos os serviços que foram iniciados a partir do arquivo docker-compose.yml

## Exemplo

```Yaml
version: "3"

services:
  # definindo a criação de um serviço
  nginx:
    build:
      # informando o PATH para o dockerfile
      dockerfile: ./docker/nginx.dockerfile
      # informando o PATH para executar o build
      context: .
    # nome para a imagem
    image: username/nginx_fusion:v1
    # nome para o container
    container_name: nginx
    # configurando a exposição de portas host-port:container-port
    ports:
      - "8080:80"
    # configurando em qual rede o container será estabelecido
    networks:
      - nwfusion
    # adicionando dependencias - executa quando as dependencias estiverem prontas
    depends_on:
      - fusion1
      - fusion2
      - fusion3

  pgfusion:
    build:
      dockerfile: ./docker/pgfusion.dockerfile
      context: .
    image: username/pgfusion:v1
    container_name: pgfusion
    ports:
      - "5432"
    networks:
      - nwfusion
    volumes:
      - pgdata:/var/lib/postgresql/data/

  fusion1:
    build:
      dockerfile: ./docker/fusion.dockerfile
      context: .
    image: username/fusion:v1
    container_name: fusion1
    ports:
      - "8000"
    networks:
      - nwfusion
    depends_on:
      - pgfusion

  fusion2:
    build:
      dockerfile: ./docker/fusion.dockerfile
      context: .
    image: username/fusion:v1
    container_name: fusion2
    ports:
      - "8000"
    networks:
      - nwfusion
    depends_on:
      - pgfusion
  
  fusion3:
    build:
      dockerfile: ./docker/fusion.dockerfile
      context: .
    image: username/fusion:v1
    container_name: fusion3
    ports:
      - "8000"
    networks:
      - nwfusion
    depends_on:
      - pgfusion

networks:
  nwfusion:
    driver: bridge

volumes:
  pgdata:
```

 - executando o build:

        docker-compose build

 - criando containers a partir das imagens:

        docker-compose up -d
        docker exec -it fusion1 python manage.py migrate

 - parar execução dos containers:

        docker-compose stop

## Docker e Microserviços

 - Escalabilidade:

   - Escalabilidade vertical: aumentar a capacidade da máquina (RAM, HD);

   - Escalabilidade horizontal: replicar a máquina/serviço N vezes;

 - Aplicação Monolítica:
 
   - Podem escalar verticalmente aumentando o poder das máquinas em que a aplicação roda ou horizontalmente com a 
   adição instâncias atrás de um Load Balancer;

 - Aplicação Microserviços:

   - É possível escalar qualquer tipo de serviço individualmente sem a necessidade de escalar todo o ambiente;
