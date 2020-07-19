# --------------------criar contato válido--------------------
Dado("que eu tenha as informações de um novo cliente") do
    @cliente = {
        "name": Faker::Name.first_name,
        "last_name": Faker::Name.last_name,
        "email": Faker::Internet.email,
        "age": Faker::Number.number(digits:2),
        "phone": "#{Faker::Number.number(digits:11)}",
        "address": "#{Faker::Address.street_name}, numero: #{Faker::Number.number(digits:2)}",
        "state": Faker::Address.state,
        "city": Faker::Address.city
    }
end
  
Quando("passo essas informações para serviço POST de contatos") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}"
    @result = post(endpoint, @cliente)
end
  
Então("o código de resposta HTTP deve ser igual a {string}") do |status_code|
    expect(@result.response.code).to eql status_code
end
  
Então("a mensagem de resposta deverá conter o Id e o Tipo do novo contato") do
    expect(@result['data']['id']).not_to be_nil
    expect(@result['data']['type']).to eql "contacts"
end

Então("os dados exibidos deverão estar corretos") do
    expect(@result['data']['attributes']['name']).to eql @cliente[:name]
    expect(@result['data']['attributes']['last-name']).to eql @cliente[:last_name]
    expect(@result['data']['attributes']['email']).to eql @cliente[:email]
    expect(@result['data']['attributes']['age']).to eql @cliente[:age]
    expect(@result['data']['attributes']['phone']).to eql @cliente[:phone]
    expect(@result['data']['attributes']['address']).to eql @cliente[:address]
    expect(@result['data']['attributes']['state']).to eql @cliente[:state]
    expect(@result['data']['attributes']['city']).to eql @cliente[:city]
end

Então("o contato deverá ser salvo no banco de dados") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}/#{@result['data']['id']}"
    result = get(endpoint)
    expect(result.response.code).to eql "200"
end

# --------------------contato inválido--------------------
Dado("que eu tenha informações inválidas de novos clientes:") do |table|
    @cliente = table.rows_hash
end

Então("devo receber uma {string} de resposta de contato inválido") do |mesagem|
    expect((@result['errors']).to_s).to include mesagem
end