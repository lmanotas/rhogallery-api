Rhogallery API
==================
This is a ruby interface to connect with the rhohub rhogallery api. 
  
  $ gem install rhogallery
  
  require 'rhogallery-api'

First of all you need to set your rhogallery credentials (username and rhogallery token):

  RhoGalleryApi.credentials = {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOGALLERY_TOKEN}

Also, you can see your credentials any time with:

  RhoGalleryApi.credentials
  => {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOHUB_RHOGALLERY_TOKEN}
  
Then you have two classes that you can work with: RhoGallery::Consumer and RhoGallery::Group, 
you can get all your consumers and groups like this:

  RhoGallery::Consumer.find_all
  => []
  RhoGallery::Group.find_all
  
or if you want to find a consumer/group by id you can:
  
  RhoGallery::Consumer.find_by_id("some_consumer_id")
  => {}
  
  RhoGallery::Group.find_by_id("some_group_id")
  => {}
  
