#language: pt

@excluir
Funcionalidade: Excluindo contatos

    Como aplicação backend de Gerenciamento de Contatos
    Quero receber contatos de clientes que deverão ser excluídos
    Para apagá-los no nosso banco de dados

Contexto:
    Dado que eu tenha criado um contato

@excluir_valido
Cenário: Excluir contato válido

    Dado que eu queira excluir um contato já existente na base de dados
    Quando passo o Id do contato para o serviço DELETE de contatos
    Então o código de resposta HTTP deve ser igual a "204"
    E o contato deverá ser excluído do banco de dados

@excluir_invalido
Cenário: Excluir contato inválido

    Dado que eu tenha um Id de contato inválido
    Quando passo o Id do contato para o serviço DELETE de contatos
    Então o código de resposta HTTP deve ser igual a "404"
    E devo visualizar uma mensagem de contato não encontrado