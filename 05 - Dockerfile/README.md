# Dockerfile

    Dockerfile -->(build)--> Imagem -->(run)--> Container

Arquivo de definição onde é possível preparar todo ambiente a partir de um script de execução. Básicamente é um
arquivo texto com instruções, comandos e passos que normalmente seriam executados manualmente.

Facilita a criação e manutenção de containers. Permite a publicação da imagem no Docker Hub e desta forma é 
possível distribui-la.

Através do comando **docker build**, o Docker realiza a execução desses passos e no final da execução ele encapsula
cada camada (layer) gerada para dentro da imagem.

O Dockerfile deve seguir uma ordem ou formatação correta para que o build seja feito de forma correta.

    COMANDO instrução

## Comandos

 - **FROM**: Informa a partir de qual imagem será gerada a nova imagem;

 - **MAINTAINER**: Campo opcional, que informa o nome do mantenedor da nova imagem;

 - **RUN**: Especifica que o argumento seguinte será executado, ou seja, realiza a execução de um comando;

 - **CMD**: Define um comando a ser executado quando um container baseado nessa imagem for iniciado, esse 
 parâmetro pode ser sobrescrito caso o container seja iniciado utilizando alguma informação de comando, como: 
 docker run -d imagem comando, neste caso o CMD da imagem será sobrescrito pelo comando informado;

 - **LABEL**: Adiciona metadados a uma imagem, informações adicionais que servirão para identificar versão, tipo 
 de licença, ou host, a cada nova instrução LABEL é criada uma nova layer, o Docker recomenda que não usar muitas 
 LABEL. É possível realizar filtragens posteriormente utilizando essas LABEL.

 - **EXPOSE**: Expõem uma ou mais portas, isso quer dizer que o container quando iniciado poderá ser acessível 
 através dessas portas;

 - **ENV**: Instrução que cria e atribui um valor para uma variável dentro da imagem, isso é útil para realizar a 
 instalação de alguma aplicação ou configurar um ambiente inteiro.

 - **ADD**: Adiciona arquivos locais ou que estejam em uma url, para dentro da imagem.

 - **COPY**: Copia arquivos ou diretórios locais para dentro da imagem.

 - **ENTRYPOINT**: Informa qual comando será executado quando um container for iniciado utilizando esta imagem, 
 diferentemente do CMD, o ENTRYPOINT não é sobrescrito, isso quer dizer que este comando será sempre executado.

 - **VOLUME**: Mapeia um diretório do host para ser acessível pelo container;

 - **USER**: Define com qual usuário serão executadas as instruções durante a geração da imagem;

 - **WORKDIR**: Define qual será o diretório de trabalho (lugar onde serão copiados os arquivos, e criadas novas 
 pastas);

 - **ONBUILD**: Define algumas instruções que podem ser realizadas quando alguma determinada ação for executada, é 
 basicamente como uma trigger.

## Criando Dockerfiles

 - Convenção para o nome do arquivo:

        Dockerfile

 - **Obs.:** caso a aplicação/projeto possua vários Dockerfiles

        postgres.dockerfile
        webserver.dockerfile

 - Exemplo 1:

```Dockerfile
FROM nginx:1.21.1-alpine
LABEL maintainer="Matheus Matias <matheus@email.com>"
COPY . /usr/share/nginx/html
EXPOSE 80
```

    docker build -f Dockerfile -t nginx-webserver:v1 .

 - f: Nome do Dockerfile (o padrão é 'PATH / Dockerfile')
 - t: Nome e, opcionalmente, uma tag no formato 'name:tag'

 - criando um container com a imagem gerada:

        docker run --name webserver -p 8080:80 -d nginx-webserver:v1

 - Exemplo 2:

```Dockerfile
FROM python:3.9.0-alpine
LABEL maintainer "Name <user@email.com>"
COPY . /var/www
WORKDIR /var/www
RUN apk update && apk add zlib-dev jpeg-dev gcc musl-dev && pip install -r requirements.txt && python manage.py migrate
ENTRYPOINT python manage.py runserver 0.0.0.0:8000
EXPOSE 8000
```

       docker build -t fusion:v1

       docker run --name fusionapp -p 8080:8000 -d fusion:v1

## Publicando uma imagem no Docker Hub

 - **Obs.:** é necessário um cadastro - https://hub.docker.com/

 - Comandos:

        docker login --username=USERNAME

        docker image push MY-IMAGE
