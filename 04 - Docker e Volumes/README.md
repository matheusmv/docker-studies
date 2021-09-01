# Docker e Volumes

 - Um container precisa ter a persistência de dados habilitada para manter alterações, por exemplo: inserir, 
 editar arquivos.

 - A solução para persistência de dados em container são os Volumes, também chamados de Volumes de Dados.

## Volumes

Compartilhar arquivos e diretórios do host para o container.

    docker run --name ngnix-server -p 8080:80 -v "host-path:container-path" -d nginx

    docker run --name nginx-server -p 8080:80 -v "/home/user/Documents/website:/usr/share/nginx/html" -d nginx

    docker run --name ngnix-server -p 8080:80 -v "$(pwd):/usr/share/nginx/html" -d nginx
