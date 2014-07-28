$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rhogallery'
require 'rspec'
require 'webmock/rspec'
include WebMock::API

class SpecHelpers

  def initialize
    WebMock.disable_net_connect!
    #groups collection
    @rhomobile_group = ({:name => "rhomobile", :id => "4e6146d5bdd0c8048c000005"})
    @koombea_group = ({:name => "koombea", :id => "4e6146d5bdd0c8048c000004"})
    #consumers collection
    @rho_consumer = ({:login => "jhon_doe", :name => "Jhon Doe", :cell => "55555", :email => "jhon@gmail.com", 
      :id => "4e6146d5bdd0c8048c000004"})
  end

#   def stub_groups_methods
#     stub_request(:get, RhoGallery.resource_url("testuser", "groups")).
#       to_return({:body => [@rhomobile_group, @koombea_group].to_json})
#     stub_request(:get, RhoGallery.resource_url("testuser", "groups/4e6146d5bdd0c8048c000004")).
#       to_return({:body => @koombea_group.to_json})
#     stub_request(:post, RhoGallery.resource_url("testuser", "groups")).
#       to_return({:status => 201, :body => "true"})
#     stub_request(:delete, RhoGallery.resource_url("testuser", "groups/4e6146d5bdd0c8048c000004")).
#       to_return({:body => "true", :status => 200})  
#   end
  
  def stub_consumers_methods
    stub_request(:get, resource_url("testuser", "consumers")).
      to_return({:body => [@rho_consumer].to_json})
    stub_request(:get, resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004")).
      to_return({:body => @rho_consumer.to_json})
    stub_request(:post, resource_url("testuser", "consumers")).
      to_return({:status => 201, :body => "true"})
    stub_request(:put, resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004")).
      to_return({:body => "true", :status => 200})
    stub_request(:delete, resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004")).
      to_return({:body => "true", :status => 200})
  end

  private

    def resource_url(username, complement)
      base_url = ENV['rhogallery_api_url']
      final_url = base_url.gsub(':username', username)
      "#{final_url}/#{complement}.json?api_token=some_token"
    end
  
    def groups_objects
      [RhoGallery::Group.new(@rhomobile_group), RhoGallery::Group.new(@koombea_group)]
    end
  
end