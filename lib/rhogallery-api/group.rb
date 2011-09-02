class Group < RhoGalleryApi
  
  def create_new(data = @attributes, options = RhoGalleryApi.credentials, resource = "groups")
    super(data, options, resource)
  end
  
  def update(data = @attributes, options = RhoGalleryApi.credentials)
    method_missing(:update)
  end
  
  def delete(options = RhoGalleryApi.credentials, resource = "groups/#{self.id}")
    super(options, resource)
  end
  
  def self.find_all(options = RhoGalleryApi.credentials)
    groups = RhoGalleryApi.find_all(options, "groups")
    groups.collect!{|group| Group.new(RhoGalleryApi.prepare_hash(group))} unless groups.empty?
  end

  def self.find_by_id(id, options = RhoGalleryApi.credentials)
    group = RhoGalleryApi.find_by_id(id, options, "groups")
    Group.new(RhoGalleryApi.prepare_hash(group))
  end

end