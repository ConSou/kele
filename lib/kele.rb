require 'HTTParty'
require 'json'
require_relative 'road_map'

class Kele
  attr_reader :user
  include HTTParty
  include RoadMap

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = self.class.post("#{@base_url}/sessions", body: {email: email, password: password})

    if response.parsed_response["auth_token"] == nil
      puts "Error retreiving auth_token.  Please ensure email and password are correct."
    else
      @auth_token = response.parsed_response["auth_token"]
      @user = get_me
    end

  end

  def get_me

    response = self.class.get("#{@base_url}/users/me", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_mentor_availability()
    unbooked_arr = []
    mentor_id = @user["current_enrollment"]["mentor_id"]
    response = self.class.get("#{@base_url}/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    converted_response = JSON.parse(response.body)
    converted_response.each do |element|
      if element["booked"] == nil
        unbooked_arr.push(element)
      end
    end
    return unbooked_arr
  end

  def get_messages(page_num = nil)

    if page_num != nil
      response = self.class.get("#{@base_url}/message_threads", headers: {"authorization" => @auth_token}, body: {page: page_num})
    else
      response = self.class.get("#{@base_url}/message_threads", headers: {"authorization" => @auth_token})
    end

    JSON.parse(response.body)
  end

  def create_message

    puts "Enter Recipient Id: "
    recipient_id = gets

    puts "Enter Subject: "
    subject = gets

    puts "Enter Message Body: "
    stripped_text = gets

    message_info = {
      sender: @user["email"],
      recipient_id: recipient_id.to_int ,
      token: "unknown",
      subject: subject,
      stripped_text: stripped_text
    }

    message_post = self.class.post("#{@base_url}/messages", headers: {"authorization" => @auth_token}, body: message_info)

  end

end
