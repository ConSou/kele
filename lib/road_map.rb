require 'HTTParty'
require 'json'

module RoadMap
  include HTTParty

  def get_roadmap()
    chain_id = @user["current_enrollment"]["chain_id"]
    response = self.class.get("#{@base_url}/roadmaps/#{chain_id}", headers: {"authorization" => @auth_token})
    roadmap_body = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("#{@base_url}/checkpoints/#{checkpoint_id}", headers: {"authorization" => @auth_token})
  end

  def get_remaining_checkpoints()
    chain_id = @user["current_enrollment"]["chain_id"]
    response = self.class.get("#{@base_url}/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

end
