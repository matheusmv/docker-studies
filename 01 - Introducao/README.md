# Introdução aos Containers e Docker

## Containers

Containers, conhecidos também por Containers Linux, são uma maneira de criar ambientes isolados que
podem executar código enquando compartilham um únco sistema operacional.

## Docker

O Docker é uma ferramenta para gerenciar containers.

## Container x Máquina Virtual

O que une o modelo de Container à Maquina Virtual é, principalmente, o fato de ambos utilizarem a
virtualização. O que muda aqui é que a virtualização se dá no vível do sistema operacional e os Containers
não utilizam hypervisor como as Máquinas Virtuais, e sim os recursos do sistema e processos de kernel para
criar os ambientes. É isso que impede o Container de ter uma visão geral do ambiente físico fora de seu
espaço, como a Máquina Virtual tem.

Na prática, o Container promove a comunicação do hardware para o sistema operacional e diretamente para
os containers, que cuidam do isolamento e da inicialização das aplicações. Na máquina virtual o hardware
se comunica com o hypervisor, e depois com a máquina. Já dentro da VM haverá inicialização do sistema
operacional e, só então, as aplicações estarão ativadas.

Isso significa que tanto o Container como a VM trabalham com virtualização e isolamento de ambientes para
promover processamentos independentes de aplicações, mas os Containers criam ambientes isolados onde diferentes
aplicações podem rodar simultaneamente, porque a divisão é feita em nível de recursos disponíveis, como
memória e processamento. Já a Máquina Virtual permite que uma máquina física abrigue outras com sistemas
operacionais diferentes, discos rígidos e hardwares independentes dos originais.

Uma das vantagens do Container é a possibilidade de criar serviços e códigos independentes, que podem ser
movidos sem dificuldade entre máquinas e ambientes diferentes sem a perda de dados.

Quando consideramos a segurança, o Container é um pouco menos robusto que a Máquina Virtual, que ainda garante
mais proteção ao usuário, mas, sem compensação, sua operação tende a ser mais rápida, uma vez que só as aplicações
precisam ser iniciadas, e não todo o sistema operacional.
