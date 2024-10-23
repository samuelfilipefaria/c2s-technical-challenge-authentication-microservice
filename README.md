#  Microserviço de autenticação de usuários

Para rodar esta aplicação é necessário ter a tecnologia Docker devidamente instalada em sua máquina. Recomendo instalar a ferramenta Docker Desktop para poder ter uma melhor visualização do que está rodando.

Este container inclui uma API (microserviço) e um banco de dados MySQL, para criar a imagem a partir do código, construir o container e iniciar o mesmo basta utilizar o seguinte comando no diretório onde o repositório foi clonado:

```
docker compose up
```

Após isso o banco de dados estará rodando na porta 4000 (db: "c2s_technical_challenge_users", user: "root", password: "root") e o microserviço na porta 5000.

## Documentação da API

- `get "/"` - retorna mensagem padrão da API
- `post "/users/create"` - criar usuário (deve incluir os parâmetros nome, email e senha)
- `post "/users/get_data"` - retornar dados do usuário (deve incluir o parâmetro token)
- `post "/users/edit"` - editar usuário (deve incluir os parâmetros nome, email e senha)
- `post "/users/login"` - logar com um usuário (deve incluir os parâmetros email e senha)
- `post "/users/destroy"` - apagar dados do usuário (deve incluir o parâmetro token)
