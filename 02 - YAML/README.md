# YAML

Yet Another Markup Language, criada em 2001 é uma linguagem não apenas de marcação, como o nome sugere, mas
sim uma linguagem de Serialização de Dados.

Serialização é a técnica que permite converter objetos em bytes (colocando-os em série) e uma vez que eles
são bytes, eles podem ser salvos em disco ou enviados através de um stream (via HTTP, socket, etc).

- Caracteristicas:

    - integração com outras linguagens, como python, ruby, java, etc;
    - possui tipos de dados comuns como escalares, listas, arrays, etc;
    - comumente utilizada como arquivo de configuração ou armazenamento de dados;

- Objetivos:

    - fácil leitura;
    - portábilidade;
    - facil integração com outras linguagens;
    - fácil de implementar e usar;

## Sintaxe

- exemplo 1:

```Yaml
        chave: valor
```

- exemplo 2:

```Yaml
        chave:
          chave: valor
          chave: valor
```

- exemplo 3:

```Yaml
        chave:
          - valor
          - valor
```

## Estilos

- block:

```Yaml
        host: geek
        datacenter:
          location: São Paulo
          router: 42
        roles:
          - web
          - dns
```

- flow:

```Yaml
        host: "geek"
        datacenter: { location: "São Paulo", router: 42 }
        roles: ["web", "dns"]
```

## Mapeamentos

```Yaml
        funcionamento: |
          segunda - das 08:00 às 17:00
          terça - das 08:00 às 17:00
          quarta - das 08:00 às 17:00
          quinta - das 08:00 às 17:00
          sexta - das 08:00 às 17:00
          sábado - das 14:00 às 17:00
          domingo - das 14:00 às 17:00

        comentarios: >
          Temos alto uso de CPU
          desde 04/10/2020.
          Estamos investigando.

            Felicity Jones
            felicity@email.com
```

## Tags

```Yaml
        %TAG ! tag:host:geek:
        ---
        host: geek
        datacenter:
          location: !GEEK São Paulo
          router: "42"
          switch: '34'
        ---
        host: udemy
        datacenter:
          location: Colorado
          router: !!str 45
          switch: !!str 23
```

## Âncoras

```Yaml
        ---
        host: geek
        datacenter:
          location: &SP São Paulo
        ---
        host: udemy
        datacenter:
          location: *SP
        ---
        roles: &services
          - webserver
          - database
        ---
        roles: *services
```
