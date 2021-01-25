# Rails Firebase Auth

Exemplo de autenticação de api rails com Firebase

## Setup

- Roda script de setup do rails

  ```sh
  bin/setup
  ```

- Copia o arquivo `.env.template` para `.env`

  ```sh
  cp .env.template .env
  ```

- Configura a variável de ambiente `FIREBASE_PROJECT_ID` no arquivo `.env`

- Roda tarefa para gerar certificado do firebase

  ```sh
  rails firebase:certificates:request
  ```

## Rodando o projeto

```sh
rails s
```

## Usando authenticação

Após o usuário criar conta ou autenticar com firebase no frontend web ou mobile, 
basta fazer as requisições para api passando o token do firebase.

Exemplo:

__Get user profile__

> GET /profile

```sh
curl -X GET 'http://localhost:3001/profile' -H 'Authorization: Bearer user-token'
```

retorno:
```json
{
  "id": 1,
  "name": "Wallas Faria da Silva",
  "email": "user@email.com",
  "phone": null,
  "auth_id": "k5LWaAsas4544hhpl7ASIH9nm282",
  "auth_provider": "google.com",
  "created_at": "2021-01-25T00:51:41.055Z",
  "updated_at": "2021-01-25T00:51:41.102Z",
  "avatar_url": "http://localhost:3001/rails/active_storage/representations..."
}
```

__Update user profile__

> PUT /profile

```sh
curl -X PUT 'http://localhost:3001/profile' \
     -H 'Authorization: Bearer user-token' \
     -H 'Content-Type: application/json' \
     -d '{ "phone": "+5522556644998" }'
```

retorno:
```json
{
  "id": 1,
  "phone": "+5522556644998",
  "name": "Wallas Faria da Silva",
  "email": "user@email.com",
  "auth_id": "k5LWaAsas4544hhpl7ASIH9nm282",
  "auth_provider": "google.com",
  "created_at": "2021-01-25T00:51:41.055Z",
  "updated_at": "2021-01-25T01:08:00.213Z",
  "avatar_url": "http://localhost:3001/rails/active_storage/representations/..."
}
```
