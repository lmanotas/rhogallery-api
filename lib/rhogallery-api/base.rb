class RhoGallery::Base
  
  def initialize(data = {})
    @attributes = data
    @errors = String.new
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
      RestClient.post RhoGallery.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
      @errors = String.new
      true
    rescue RestClient::RequestFailed => e
      @errors = e.response.body
      false
    end
  end
  
  def update(data, options, resource)
    begin
      RestClient.put RhoGallery.resource_url(options[:username], resource), data, {:Authorization => options[:token]}
      true
      @errors = String.new
    rescue RestClient::RequestFailed => e
      @errors = e.response.body
      false
    end
  end
  
  def delete(options, resource)
    RestClient.delete RhoGallery.resource_url(options[:username], resource), {:Authorization => options[:token]}
    true
  end
  
  def self.find_all(options, resource)
    res = RestClient::Resource.new(RhoGallery.resource_url(options[:username], "#{resource}"), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end

  def self.find_by_id(id, options, resource)
    res = RestClient::Resource.new(RhoGallery.resource_url(options[:username], "#{resource}/#{id}"), :headers => {:Authorization => options[:token]})
    JSON.parse res.get
  end
  
  def method_missing(method_sym, *arguments, &block)
    @attributes = RhoGallery.prepare_hash(@attributes)
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