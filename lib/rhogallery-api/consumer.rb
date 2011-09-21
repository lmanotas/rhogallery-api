class RhoGallery::Consumer < RhoGallery::Base
  
  def create_new(data = @attributes, options = RhoGallery.credentials, resource = "consumers")
    super(data, options, resource)
  end

  def update(data = @attributes, options = RhoGallery.credentials, resource = "consumers/#{self.id}")
    if super(data, options, resource)
      @attributes = RhoGallery::Consumer::find_by_id(self.id, options).get_attributes
      self
    else
      false
    end
  end

  def delete(options = RhoGallery.credentials, resource = "consumers/#{self.id}")
    super(options, resource)
  end

  def self.find_by_id(id = "", options = RhoGallery.credentials)
    consumer = RhoGallery::Base.find_by_id(id, options, "consumers")
    RhoGallery::Consumer.new(RhoGallery.prepare_hash(consumer))
  end

  def self.find_all(options = RhoGallery.credentials)
    consumers = RhoGallery::Base.find_all(options, "consumers")
    consumers.collect!{|consumer| RhoGallery::Consumer.new(RhoGallery.prepare_hash(consumer))} unless consumers.empty?
  end

end