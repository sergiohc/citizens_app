## Este app usa Docker, caso não o tenha siga ...

Você precisará ter o [Docker instalado](https://docs.docker.com/get-docker/).
Ele está disponível no Windows, macOS e na maioria das distribuições do Linux. Se você é novo no
Docker e quer aprender em detalhes, confira os [links de recursos adicionais](#aprenda-mais-sobre-docker-e-ruby-on-rails)

Você também precisará habilitar o suporte ao Docker Compose v2 se estiver usando o Docker
Desktop. No Linux nativo sem o Docker Desktop, você pode [instalá-lo como um plugin
do Docker](https://docs.docker.com/compose/install/linux/). Ele está geralmente
disponível há algum tempo e é estável. Este projeto usa específicos [Docker Compose v2 recursos](https://nickjanetakis.com/blog/optional-depends-on-with-docker-compose-v2-20-2)
que só funcionam com o Docker Compose v2 2.20.2+.

Se você estiver usando o Windows, espera-se que você esteja seguindo dentro
do [WSL ou WSL2](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more).
Isso porque vamos executar comandos shell. Você sempre pode modificar
esses comandos para o PowerShell, se quiser.

#### Clone este repositório em qualquer lugar que desejar:

```sh
git clone git@github.com:sergiohc/
cd citizen
```

#### Copie o arquivo .env de exemplo:

```sh
cp .env.example .env
```

## Configuração do Projeto

1. Construa e inicie os serviços do Docker:

```bash
docker compose up --build
```

2. Em outro terminal, execute o seguinte comando para configurar o banco de dados:

```bash
./run db:setup
```

3. Acesse a aplicação em seu navegador:

```
http://localhost:8000/
```

## Executando Testes

Para executar os testes, siga os passos abaixo:

1. Inicie os serviços do Docker, se ainda não estiverem em execução:

```bash
docker compose up
```

2. Em outro terminal, execute os testes com o seguinte comando:

```bash
./run test
```
