module RhoGallery
  
  def self.credentials=(user_credentials)
    user_credentials = prepare_hash(user_credentials)
    if user_credentials[:username] and user_credentials[:token]
      ENV['rhogallery_username'] = user_credentials[:username]
      ENV['rhogallery_token'] = user_credentials[:token]
    else
      raise "Invalid RhoGallery credentials. correct format: {:username => 'your username', :token => 'your rhogallery token'}"
    end
  end
  
  def self.credentials
    if ENV['rhogallery_username'] and ENV['rhogallery_token']
      {:username => ENV['rhogallery_username'], :token => ENV['rhogallery_token']}
    else
      raise "You must set up your rhogallery credentials see README file"
    end
  end
  
  def self.resource_url(username = ENV['rhogallery_username'], resource = "")
    base_url = ENV['rhogallery_api_url'].gsub(/:username/, username)
    base_url.gsub(/:resource/, resource)
  end
  
  def self.prepare_hash(data_parsed)
    data = {}
    data_parsed.each{|k,v| data.merge!({k.to_sym => v})}
    data
  end
  
end