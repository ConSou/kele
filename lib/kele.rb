require 'HTTParty'
require 'json'

class Kele
  attr_reader :user
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: {email: email, password: password})
    @auth_token = response.parsed_response["auth_token"]
    @user = get_me
  end

  def get_me

    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_mentor_availability()
    unbooked_arr = []
    mentor_id = @user["current_enrollment"]["mentor_id"]
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    converted_response = JSON.parse(response.body)
    converted_response.each do |element|
      if element["booked"] == nil
        unbooked_arr.push(element)
      end
    end
    return unbooked_arr
  end


end
