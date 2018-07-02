require 'HTTParty'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'
    @auth_token = self.class.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password})
  end

end
