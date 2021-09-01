# Docker e Imagens

## Imagens

 - 'Templates' para criar containers

 - Exemplo: uma aplicação desenvolvida com Python e banco de dados PostgreSQL será executada no servidor web Ngnix.
 Serão criados 3 containers:
    - Um container irá usar uma imagem com a linguagem Python contendo suporte a se comunicar com o banco de dados
    PostgreSQL;
    - Um container irá usar uma imagem com o servidor de banco de dados PostgreSQL;
    - Um container irá user uma imagem com o servidor web Ngnix;

 - Primeiro o docker tenta encontrar um imagem localmente e caso não encotre ele faz o download na plataforma
 Docker Hub

 - Uma imagem é criada a partir de um arquivo Dockerfile

 - Imagens são compartilhadas entre containers Docker. Permite a utilização de uma imagem em containers diferentes

## Sistema de arquivos em camada

O sistema de arquivos do Docker é chamado de Layered, ou seja, é um sistema de arquivos em camadas.

 - Sistemas de arquivos: um sistema de arquivos comum (Linux/Unix), possui basicamente duas camadas

    - bootfs: onde fica o sistema de Boot do sistema operacional e o Kernel.
    - rootfs: inclui o sistema de arquivos do sistema operacional, incluindo a arquitetura de diretórios, como
    /dev, /proc, /bin, /etc, /lib, /usr e /tmp assim como os arquivos de configuração e binários do sistema
    operacional.

    Quando o sistema operacional é iniciado ele carrega o rootfs primeiramente em modo somente leitura, verifica 
    sua integridade e em seguida remonta-o como leitura/escrita e assim fica disponível para o usuário e 
    aplicações.

 - Sistemas de arquivos no Docker:

    - A camada de escrita que o processo/aplicação visualiza não é o mesmo rootfs base do sistema mas sim uma
    camada de abstração do rootfs. Isso torna o container portável, pois as modificações realizadas não são 
    aplicadas ao sistema origem do container e sim na camda a qual o sistema visualiza.

    - O bootfs é compartilhado entre a máquina host e o container, já o rootfs é isolado por camadas, ou seja, o
    que deve ser comum entre o host e o container é compartilhado via AUFS, que monta um camada de leitura/escrita
    em cima do sistema de arquivos que é somente leitura. Isso garante que modificações feitas dentro do container
    não afetem o sistema de arquivos do host.

## Comandos básicos

 - versão do docker:

        docker --version
        docker -V

 - listar comandos:

        docker --help
        docker container --help

 - obter uma imagem do docker hub:

        docker pull postgres
        docker pull postgres:13.1

 - listar imagens instaladas:

        docker image ls
        docker images

 - remover uma imagem instalada:

        docker image rm 'image-id'
        docker image rm 'image-id' -f

 - listar containers que estão em execução:

        docker container ls
        docker ps

 - listar todos os containers (execução/parados):

        docker ps -a

 - iniciar um container:

        docker container start 'container-id'/'name'
        docker run 'container-id'/'name'

 - remover um container:

        docker rm 'container-id/name'
        docker rm $(docker ps -aq)

 - inspecionar parâmetros:

        docker image inspect 'image-id/name:tag'
        docker inspect 'container-id/name'

 - criar uma tag a partir de imagem uma pré-instalada:

        docker image tag 'local-image-name:local-image-tag' 'new-image'

 - acesso ao container em modo iterativo:

        docker exec -it 'nome-do-container' sh
        docker exec -it 'nome-do-container' bash
        docker exec -it 'nome-do-container' /bin/bash

## Criando um container a partir de uma imagem

    docker pull nginx:1.21.1-alpine

    docker run --name nginx-server -p 8080:80 -d nginx:1.21.1-alpine

 - -d: Executa o contêiner em segundo plano e imprime o ID do contêiner
 - --name: Atribuir um nome ao container
 - -p: Publica a (s) porta (s) de um contêiner para o host
