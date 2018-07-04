require 'HTTParty'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = self.class.post("#{@base_url}/sessions", body: {email: email, password: password})
    @auth_token = response.parsed_response["auth_token"]
  end

  def get_me

    response = self.class.get("#{@base_url}/users/me", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

end
