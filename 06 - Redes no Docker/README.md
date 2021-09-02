# Redes no Docker

O Docker cria uma abstração para facilitar o gerenciamento da comunicação de dados entre containers e o host.

O Docker é disponilizado com três redes por padrão - Bridge, None e Host. Essas redes oferecem configurações 
específicas para gerenciamento do tráfego de dados.

 - Comando para visualizar as interfaces de rede:

        docker network ls

## Bridge

Cada container iniciado no Docker é associado a rede específica. Essa é a rede padrão para qualquer container, a
menos que associemos, explicitamente, outra rede a ele. A rede confere ao container um interface que faz bridge
com a interface docker0 do docker host. Essa interface recebe, automaticamente, o próximo endereço disponível na
rede IP 172.17.0.0/16.

O containers configurados para essa rede terão a possibilidade de tráfego externo utilizando as rotas das rede IP
definidas no docker host. Caso o docker host tenha acesso a Internet, automaticamente, os containers em questão
também terão.

 - Todos os containers que estão nessa rede podem se comunicar via protocolo TCP/IP.
 
 - Nessa rede é possível expor portas dos containers para todos os ativos com acesso ao docker host.

## None

Essa rede tem como objetivo isolar o container para comunicações externas. A rede não recebe qualquer interface
para comunicação externa. A única interface de rede IP será a localhost.

 - Essa rede normalmente é utilizada para containers que manipulam apenas arquivos, sem necessidade de enviá-los
 via rede para outro local - Backup.

# Host

Essa rede tem como objetivo entregar para o container todas as interfaces existentes no docker host. Pode agilizar
a entrega dos pacotes, uma vez que não há bridge no caminho das mensagens. Mas normalmente esse overhead é mínimp e
o uso de uma bridge pode ser importante para segurança do tráfego.

## Redes definidas pelo usuário

O Docker possibilita que o usuário crie redes. Essas redes são associadas ao elemento que o docker chama de driver
de rede. Cada rede criada por usuário deve estar associada a um determinado driver. E, caso você não crie seu
próprio driver, deve escolher entre os drivers disponibilizados pelo docker.

### Bridge

 - Driver de rede mais simples de utilizar, pois demanda pouca configuração;
 
 - Assemelha-se à rede padrão do Docker denominada "bridge" - ***o docker tem uma rede padrão chamada “bridge”*** 
 ***que utiliza um driver também chamado de “bridge“.***;
 
 - As redes criadas pelo usuário com o driver bridge tem todas as funcionalidades descritas na rede padrão, 
 chamada bridge. Porém, com funcionalidades adicionais.
    - DNS interno do Docker que associa automaticamente todos os nomes de containers dessa rede para seus
    respectivos IPs da rede IP correspondente. ***Os containers que estiverem utilizando a rede padrão bridge*** 
    ***não poderão usufruir da funcionalidade de DNS interno do Docker***

 - Um container que está em determinada rede não acessa outro container que está em outra rede. Para que um 
 container acesse outro container de outra rede, é necessário que a origem esteja presente nas duas redes que 
 deseja alcançar.

 - Comando para criar uma rede:

        docker network create --driver bridge new_network

 - Iniciar um container na rece new_network:

        docker container run -itd --net new_network ubuntu:20.04 sh

 - Descobrir quais containers estão associados a uma determinada rede:

        docker network inspect new_network

### Overlay

O driver overlay permite comunicação entre hosts docker, utilizando-o os containers de um determinado host docker 
poderão acessar, nativamente, containers de um outro ambiente docker.

## Criando uma rede para comunicação

 - Iniciando um container na rede bridge:

        docker rum --rm ubuntu:20.04 sh -c "ifconfig"

 - Iniciando um container na rede none:

        docker run --net none --rm ubuntu:20.04 sh -c "ifconfig"

 - Inciando um container na rede host:

        docker run --net host --rm ubuntu:20.04 sh -c "ifconfig"

 - Criando uma ponte entre duas redes diferentes: uma nova interface será configurada no container.

        docker network create --driver bridge network1
        docker network connect 'rede' 'container'
        docker network connect bridge network1

 - Desfazendo a ponte entre as redes: a interface será removida do container.

        docker network disconnect bridge network1
