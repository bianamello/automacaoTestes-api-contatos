# --------------------contexto--------------------
Dado("que eu tenha criado um contato") do
    @contato = {
        "name": Faker::Name.first_name,
        "last_name": Faker::Name.last_name,
        "email": Faker::Internet.email,
        "age": Faker::Number.number(digits:2),
        "phone": "#{Faker::Number.number(digits:11)}",
        "address": "#{Faker::Address.street_name}, numero: #{Faker::Number.number(digits:2)}",
        "state": Faker::Address.state,
        "city": Faker::Address.city
    }
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}"
    @result = post(endpoint, @contato)
    expect(@result.response.code).to eql "201"
end

# --------------------excluir contato válido--------------------
Dado("que eu queira excluir um contato já existente na base de dados") do
    @id_contato = (@result['data']['id'])
end

Quando("passo o Id do contato para o serviço DELETE de contatos") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}/#{@id_contato}"
    @result = delete(endpoint)
end

Então("o contato deverá ser excluído do banco de dados") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}/#{@id_contato}"
    result = get(endpoint)
    expect(result.response.code).to eql "404"
    expect(result['error']).to eql "Not Found"
end

# --------------------excluir contato inválido--------------------
Dado("que eu tenha um Id de contato inválido") do
    @id_contato = "acbd"
end

Então("devo visualizar uma mensagem de contato não encontrado") do
    expect(@result['error']).to eql "Not Found"
end