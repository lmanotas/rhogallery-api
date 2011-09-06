$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rhogallery-api'
require 'rspec'
require 'webmock/rspec'
include WebMock::API

class SpecHelpers

  def initialize
    ENV['rhogallery_username'] = "testuser"
    ENV['rhogallery_token'] = "some_uuid_token"
    WebMock.disable_net_connect!
    #gorups collection
    @rhomobile_group = ({:name => "rhomobile", :id => "4e6146d5bdd0c8048c000005"})
    @koombea_group = ({:name => "koombea", :id => "4e6146d5bdd0c8048c000004"})
    #consumers collection
    @rho_consumer = ({:login => "some_login", :name => "rhohub consumer", :cell => "55555", :email => "email@rhohub.com", 
      :id => "4e6146d5bdd0c8048c000004"})
  end
  
  def stub_groups_methods
    stub_request(:get, "http://rhohub.local/rhogallery/api/v1/testuser/groups.json").
      to_return({:body => [@rhomobile_group, @koombea_group].to_json})
    stub_request(:get, "http://rhohub.local/rhogallery/api/v1/testuser/groups/4e6146d5bdd0c8048c000004.json").
      to_return({:body => @koombea_group.to_json})
    stub_request(:post, "http://rhohub.local/rhogallery/api/v1/testuser/groups.json").
      to_return({:status => 201, :body => "true"})
    stub_request(:delete, "http://rhohub.local/rhogallery/api/v1/testuser/groups/4e6146d5bdd0c8048c000004.json").
      to_return({:body => "true", :status => 200})  
  end
  
  def stub_consumers_methods
    stub_request(:get, "http://rhohub.local/rhogallery/api/v1/testuser/consumers.json").
      to_return({:body => [@rho_consumer].to_json})
    stub_request(:get, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json").
      to_return({:body => @rho_consumer.to_json})
    stub_request(:post, "http://rhohub.local/rhogallery/api/v1/testuser/consumers.json").
      to_return({:status => 201, :body => "true"})
    stub_request(:put, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json").
      to_return({:body => "true", :status => 200})
    stub_request(:delete, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json").
      to_return({:body => "true", :status => 200})
  end
  
  def groups_objects
    [RhoGallery::Group.new(@rhomobile_group), RhoGallery::Group.new(@koombea_group)]
  end
  
end