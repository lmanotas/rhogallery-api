require File.join(File.dirname(__FILE__), 'spec_helper')

describe RhoGallery::Consumer do

  before(:each) do
    @spec_helpers = SpecHelpers.new
    @spec_helpers.stub_consumers_methods
  end

  context "GET request" do
    it "should make a GET request to get all the consumers" do
      RhoGallery::Consumer.find_all
      WebMock.should have_requested(:get, "http://rhohub.local/rhogallery/api/v1/testuser/consumers.json")
    end
    
    it "should make a GET request to get a consumer by ID" do
      RhoGallery::Consumer.find_by_id("4e6146d5bdd0c8048c000004")
      WebMock.should have_requested(:get, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json")
    end
  end
  
  context "Create, update and Delete actions" do
    it "should send a POST request to save a new consumer" do
      new_cons = RhoGallery::Consumer.new({:login => "testconsumer", :name => "this is a name"})
      new_cons.create_new
      WebMock.should have_requested(:post, "http://rhohub.local/rhogallery/api/v1/testuser/consumers.json")
    end
    it "should send a PUT request to update a consumer" do
      consumer = RhoGallery::Consumer.find_by_id("4e6146d5bdd0c8048c000004")
      consumer.login = "new_login_for_this_consumer"
      consumer.update
      WebMock.should have_requested(:put, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json")
    end
    it "should send a DELETE request to delete a consumer" do
      consumer = RhoGallery::Consumer.find_by_id("4e6146d5bdd0c8048c000004")
      consumer.delete
      WebMock.should have_requested(:delete, "http://rhohub.local/rhogallery/api/v1/testuser/consumers/4e6146d5bdd0c8048c000004.json")
    end
  end
  
  context "Get and set consumers values" do
    it "should get the consumer values and set new values" do
      consumer = RhoGallery::Consumer.find_by_id("4e6146d5bdd0c8048c000004")
      consumer.login.should == "some_login"
      consumer.login = "the_new_login"
      consumer.login.should == "the_new_login"
    end
  end
end