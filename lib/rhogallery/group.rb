class RhoGallery::Group < RhoGallery::Base

  def create(data = @attributes, options = RhoGallery.credentials, resource = "groups")
    super(data, options, resource)
  end

  def save(data = @attributes, options = RhoGallery.credentials, resource = "groups")
    super(data, options, resource)
  end

  def update(data = @attributes, options = RhoGallery.credentials)
    method_missing(:update)
  end

  def delete(options = RhoGallery.credentials, resource = "groups/#{self.id}")
    super(options, resource)
  end

  def self.find_all(options = RhoGallery.credentials)
    groups = RhoGallery::Base.find_all(options, "groups")
    groups.collect!{|group| RhoGallery::Group.new(RhoGallery.prepare_hash(group))} unless groups.empty?
  end

  def self.find(id, options = RhoGallery.credentials)
    group = RhoGallery::Base.find(id, options, "groups")
    RhoGallery::Group.new(RhoGallery.prepare_hash(group))
  end

end