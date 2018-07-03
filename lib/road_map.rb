require 'HTTParty'
require 'json'

module RoadMap
  include HTTParty

  def get_roadmap()
    chain_id = @user["current_enrollment"]["chain_id"]
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{chain_id}", headers: {"authorization" => @auth_token})
    roadmap_body = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: {"authorization" => @auth_token})
  end

end
