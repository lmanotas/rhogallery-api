require "rubygems"
require "json"
require "rest_client"
require "rhogallery/version"
require "rhogallery/rho_gallery"
require "rhogallery/base"
require "rhogallery/consumer"
require "rhogallery/group"
ENV['rhogallery_api_url'] = "https://app.rhohub.com/rhogallery/api/v1/:username/:resource.json"