require "rubygems"
require "json"
require "rest_client"
require "rhogallery-api/version"
require "rhogallery-api/consumer"
require "rhogallery-api/group"

ENV['rhogallery_token'] = "a9c2f0a3fd7146b7b814b3a2ae8a3606"
ENV['rhogallery_username'] = "luis"
ENV['rhogallery_api_url'] = "http://rhohub.local/rhogallery/api/v1/:username/:resource.json"