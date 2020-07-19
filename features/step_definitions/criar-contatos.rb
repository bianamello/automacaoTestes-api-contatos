# --------------------criar contato válido--------------------
Dado("que eu tenha as informações de contato de um novo cliente") do
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
end
  
Quando("passo essas informações para serviço POST de contatos") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}"
    @result = post(endpoint, @contato)
end
  
Então("o código de resposta HTTP deve ser igual a {string}") do |status_code|
    expect(@result.response.code).to eql status_code
end
  
Então("a mensagem de resposta deverá conter o Id e o Tipo do novo contato") do
    expect(@result['data']['id']).not_to be_nil
    expect(@result['data']['type']).to eql "contacts"
end

Então("os dados exibidos deverão estar corretos") do
    expect(@result['data']['attributes']['name']).to eql @contato[:name]
    expect(@result['data']['attributes']['last-name']).to eql @contato[:last_name]
    expect(@result['data']['attributes']['email']).to eql @contato[:email]
    expect(@result['data']['attributes']['age']).to eql @contato[:age]
    expect(@result['data']['attributes']['phone']).to eql @contato[:phone]
    expect(@result['data']['attributes']['address']).to eql @contato[:address]
    expect(@result['data']['attributes']['state']).to eql @contato[:state]
    expect(@result['data']['attributes']['city']).to eql @contato[:city]
end

Então("o contato deverá ser salvo no banco de dados") do
    endpoint = "#{CONFIG['apis']['base_url']}#{CONFIG['apis']['contacts']}/#{@result['data']['id']}"
    result = get(endpoint)
    expect(result.response.code).to eql "200"
end

# --------------------contato inválido--------------------
Dado("que eu tenha informações inválidas de contato:") do |table|
    @contato = table.rows_hash
end

Então("devo receber uma {string} de resposta de contato inválido") do |mesagem|
    expect((@result['errors']).to_s).to include mesagem
end