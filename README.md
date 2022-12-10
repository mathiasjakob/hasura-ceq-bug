# hasura-ceq-bug
This repo demonstrates a potential column reference bug in Hasura 2.16.0.
Issue Link: https://github.com/hasura/graphql-engine/issues/9283

## Steps to reproduce
1. run `docker-compose up`
2. cd to `hasura` directory and run `hasura console --admin-secret "changeme"`.
3. go to API tab and add the Authorization header as a Bearer token with the jwt token from below. The token contains `x-hasura-user-id` = `1` and `x-hasura-allowed-roles` = `["user"]`.
4. disable the `x-hasura-admin-secret` header.
5. go to API tab and run the following query:
```graphql
query author
{
  author{
    id
  }
}
```
**-> All authors are returned**

6. go to API tab and run the following query:
```graphql
query article{
  article{
    id
    author{
      id
      name
    }
  }
}
```
**-> All articles with their authors are returned**

7. go to API tab and run the following query:
```graphql
query defective
{
  article(where: {author: {id: {_is_null: false}}}) {
    id
    author {
      id
      name
    }
  }
}
```
**-> Empty array is returned**



## JWT
### Encoded Token
eyJhbGciOiJSUzI1NiIsImFscGhhIjoicm5lcjM4dnE1OW93emFzYmZhdzUifQ.eyJhdWQiOiIzYTIyZmMxMy03ZTk0LTRhYjQtYWE1Yy04MTljYmQxOGRiZGQiLCJleHAiOjE3NjUzODczMzksImlhdCI6MTY3MDY5MjQ1MCwiaXNzIjoicHJvZGxhbmUuaW8iLCJzdWIiOiJmYTdlYzI2Yy01NjI2LTQ5YjYtODIxNi1jNjgzMzY3ZTg5NzAiLCJqdGkiOiJiMjZjZGZmMy1iNDE2LTRlMzQtOWVkMS02NjIxOTk1NjIxZTciLCJ0aWQiOiIxOGY2MzAwMi1lMTkwLTQxNWMtOGYxNC1jOGUxM2ZmNTRmNWUiLCJhdXRoX3RpbWUiOjE2NzA2ODQzOTYsInNpZCI6Ijg1YmMxN2Y0LTczNDUtNDRjOS04MzUwLTlmZGRiMmY5NjllZSIsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtYWxsb3dlZC1yb2xlcyI6WyJ1c2VyIl0sIngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS11c2VyLWlkIjoiMSJ9fQ.Uzce5oLNR3lLS_2QK-TJOXq2M5odY0BIfUYa2gFQtnQitH6pfy5mmdfmgSkcEV_wmoMl6Yfvlw19Wr7wpA-bhg

## Queries 
```graphql
query author
{
  author{
    id
  }
}

query article{
  article{
    id
    author{
      id
      name
    }
  }
}

query defective
{
  article(where: {author: {id: {_is_null: false}}}) {
    id
    author {
      id
      name
    }
  }
}
```
