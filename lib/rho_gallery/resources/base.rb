require 'active_resource'

class RhoGallery::Base < ActiveResource::Base
  ENV['rhogallery_api_url'] = "https://app.rhohub.com/rhogallery/api/v1/:username"
  self.site = ENV['rhogallery_api_url']
  self.format = :json
end