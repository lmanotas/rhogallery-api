class Group
  def self.find_all(options = {:username => ENV['rhogallery_username'], :token => ENV['rhogallery_token']})
    res = RestClient::Resource.new(resource_url(options[:username]), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end

  def self.find_by_id(id, options = {:username => ENV['rhogallery_username'], :token => ENV['rhogallery_token']})
    res = RestClient::Resource.new(resource_url(options[:username], "groups/#{id}"), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end

  def self.resource_url(username = ENV['rhogallery_username'], resource = "groups")
    base_url = ENV['rhogallery_api_url'].gsub(/:username/, username)
    base_url.gsub(/:resource/, resource)
  end
end