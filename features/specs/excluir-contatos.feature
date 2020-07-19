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

    Quando passo o Id para o serviço DELETE
    Então o código de resposta HTTP deve ser igual a "204"
    E a exclusão deverá ser realizada com sucesso

@excluir_invalido
Cenário: Excluir contato inválido

    Dado que eu tenha um Id inválido
    Quando passo o Id para o serviço DELETE
    Então o código de resposta HTTP deve ser igual a "404"
    E devo visualizar uma mensagem de contato não encontrado