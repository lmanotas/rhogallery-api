module RhoGallery
  class Consumer < RhoGalleryApi
    
    def create_new(data = @attributes, options = RhoGalleryApi.credentials, resource = "consumers")
      super(data, options, resource)
    end
  
    def update(data = @attributes, options = RhoGalleryApi.credentials, resource = "consumers/#{self.id}")
      super(data, options, resource)
      Consumer::find_by_id(self.id, options)
    end
  
    def delete(options = RhoGalleryApi.credentials, resource = "consumers/#{self.id}")
      super(options, resource)
    end
  
    def self.find_by_id(id = "", options = RhoGalleryApi.credentials)
      consumer = RhoGalleryApi.find_by_id(id, options, "consumers")
      Consumer.new(RhoGalleryApi.prepare_hash(consumer))
    end
  
    def self.find_all(options = RhoGalleryApi.credentials)
      consumers = RhoGalleryApi.find_all(options, "consumers")
      consumers.collect!{|consumer| Consumer.new(RhoGalleryApi.prepare_hash(consumer))} unless consumers.empty?
    end
  
  end
end