require "rubygems"
require "json"
require "rest_client"
require "rhogallery-api/version"
require "rhogallery-api/rho_gallery_api"
require "rhogallery-api/consumer"
require "rhogallery-api/group"

ENV['rhogallery_api_url'] = "http://rhohub.local/rhogallery/api/v1/:username/:resource.json"