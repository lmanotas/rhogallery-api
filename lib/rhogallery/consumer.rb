class RhoGallery::Consumer < RhoGallery::Base
  
  def create(data = @attributes, options = RhoGallery.credentials, resource = "consumers")
    super(data, options, resource)
  end

  def save(data = @attributes, options = RhoGallery.credentials, resource = "consumers")
    super(data, options, resource)
  end

  def update(data = @attributes, options = RhoGallery.credentials, resource = "consumers/#{self.id}")
    if super(data, options, resource)
      @attributes = RhoGallery::Consumer::find(self.id, options).get_attributes
      self
    else
      false
    end
  end

  def delete(options = RhoGallery.credentials, resource = "consumers/#{self.id}")
    super(options, resource)
  end

  def self.find(id = "", options = RhoGallery.credentials)
    consumer = RhoGallery::Base.find(id, options, "consumers")
    RhoGallery::Consumer.new(RhoGallery.prepare_hash(consumer))
  end

  def self.find_all(options = RhoGallery.credentials)
    consumers = RhoGallery::Base.find_all(options, "consumers")
    consumers.collect!{|consumer| RhoGallery::Consumer.new(RhoGallery.prepare_hash(consumer))} unless consumers.empty?
  end

end