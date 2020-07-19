#language: pt

Funcionalidade: Criando contatos

    Como aplicação backend de Gerenciamento de Contatos
    Quero implementar o fluxo de salvar contatos de novos clientes
    Para gravá-los no nosso banco de dados

@criar
Cenário: Contato válido

    Dado que eu tenha as informações de contato de um novo cliente
    Quando passo essas informações para serviço POST de contatos
    Então o código de resposta HTTP deve ser igual a "201"
    E a mensagem de resposta deverá conter o Id e o Tipo do novo contato
    E os dados exibidos deverão estar corretos
    E o contato deverá ser salvo no banco de dados

@criar
Esquema do Cenário: Contato inválido

    Dado que eu tenha informações inválidas de contato:
        | name      | <name>      |
        | last_name | <last_name> |
        | email     | <email>     |
        | age       | <age>       |
        | phone     | <phone>     |
        | address   | <address>   |
        | state     | <state>     |
        | city      | <city>      |
    Quando passo essas informações para serviço POST de contatos
    Então o código de resposta HTTP deve ser igual a "422"
    E devo receber uma "<mesagem>" de resposta de contato inválido

    Exemplos:
        | name | last_name | email        | age | phone     | address | state | city | mesagem                  |
        |      | Mello     | fabi@bol.com | 33  | 933996677 | Rua 1   | SP    | SP   | não pode ficar em branco |
        | Fabi | Mello     |              | 33  | 933996677 | Rua 1   | SP    | SP   | não pode ficar em branco |
        | Fabi | Mello     | teste        | 33  | 933996677 | Rua 1   | SP    | SP   | não é válido             |
        | Fabi | Mello     | fabi@bol.com |     | 933996677 | Rua 1   | SP    | SP   | não é um número          |
        | Fabi | Mello     | fabi@bol.com | ab  | 933996677 | Rua 1   | SP    | SP   | não é um número          |
        | Fabi | Mello     | fabi@bol.com | 33  |           | Rua 1   | SP    | SP   | não é válido             |
        | Fabi | Mello     | fabi@bol.com | 33  | abcdef    | Rua 1   | SP    | SP   | não é válido             |