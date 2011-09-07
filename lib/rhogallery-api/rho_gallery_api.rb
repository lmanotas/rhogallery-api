class RhoGalleryApi
  
  def initialize(data = {})
    @attributes = data
    @errors = String.new
  end
  
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
  
  def id
    @attributes[:id]
  end
  
  def errors
    @errors.strip
  end
  
  protected
  
  def get_attributes
    @attributes
  end
  
  def create_new(data, options, resource)
    begin
      RestClient.post RhoGalleryApi.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
      @errors = String.new
      true
    rescue RestClient::RequestFailed => e
      @errors = e.response.body
      false
    end
  end
  
  def update(data, options, resource)
    RestClient.put RhoGalleryApi.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
    true
  end
  
  def delete(options, resource)
    RestClient.delete RhoGalleryApi.resource_url(options[:username], resource), {:Authorization => options[:token]}
    true
  end
  
  def self.find_all(options, resource)
    res = RestClient::Resource.new(RhoGalleryApi.resource_url(options[:username], "#{resource}"), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end

  def self.find_by_id(id, options, resource)
    res = RestClient::Resource.new(RhoGalleryApi.resource_url(options[:username], "#{resource}/#{id}"), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end
  
  def method_missing(method_sym, *arguments, &block)
    @attributes = RhoGalleryApi.prepare_hash(@attributes)
    if method_sym.to_s.slice("=")
      att = method_sym.to_s.split("=").first.strip
      if @attributes[att.to_sym]
        @attributes[att.to_sym] = arguments.to_s
      else
        super
      end
    else
      att = @attributes[method_sym]
      if att
        att
      else
        super
      end
    end
  end
end