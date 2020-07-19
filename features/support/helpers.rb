def post(endpoint, body)
    HTTParty.post(
        endpoint,
        headers: {'Content-Type' => 'application/json'},
        body: body.to_json
    )
end

def get(endpoint)
	HTTParty.get(endpoint)
end

def delete(endpoint)
    HTTParty.delete(endpoint)
end