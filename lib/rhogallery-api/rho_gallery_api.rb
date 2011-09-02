class RhoGalleryApi
  
  def initialize(data = {})
    @attributes = data
  end
  
  def self.credentials
    {:username => ENV['rhogallery_username'], :token => ENV['rhogallery_token']}
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
  
  protected
  
  def create_new(data, options, resource)
    RestClient.post RhoGalleryApi.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
    true
  end
  
  def update(data, options, resource)
    RestClient.put RhoGalleryApi.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
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
  
  def id
    @attributes[:id]
  end
  
  def method_missing(method_sym, *arguments, &block)
    att = @attributes[method_sym] or @attributes[method_sym.to_s]
    if att
      att
    else
      super
    end
  end
  
end