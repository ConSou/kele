require 'HTTParty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password})
    if response.parsed_response["auth_token"] == nil
      puts "Error retreiving auth_token.  Please ensure email and password are correct."
    else
      @auth_token = response.parsed_response["auth_token"]
    end

  end

end
