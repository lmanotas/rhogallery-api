require File.join(File.dirname(__FILE__), 'spec_helper')

describe RhoGallery::Consumer do

  before(:each) do
    @spec_helpers = SpecHelpers.new
    @spec_helpers.stub_consumers_methods
  end

  context "GET request" do
    it "should make a GET request to get all the consumers" do
      RhoGallery::Consumer.find_all
      WebMock.should have_requested(:get, RhoGallery.resource_url("testuser", "consumers"))
    end
    
    it "should make a GET request to get a consumer by ID" do
      RhoGallery::Consumer.find("4e6146d5bdd0c8048c000004")
      WebMock.should have_requested(:get, RhoGallery.resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004"))
    end
  end
  
  context "Create, update and Delete actions" do
    it "should send a POST request to save a new consumer" do
      new_cons = RhoGallery::Consumer.new({:login => "testconsumer", :name => "this is a name"})
      new_cons.save
      WebMock.should have_requested(:post, RhoGallery.resource_url("testuser", "consumers"))
    end
    it "should send a PUT request to update a consumer" do
      consumer = RhoGallery::Consumer.find("4e6146d5bdd0c8048c000004")
      consumer.login = "new_login_for_this_consumer"
      consumer.update
      WebMock.should have_requested(:put, RhoGallery.resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004"))
    end
    it "should send a DELETE request to delete a consumer" do
      consumer = RhoGallery::Consumer.find("4e6146d5bdd0c8048c000004")
      consumer.delete
      WebMock.should have_requested(:delete, RhoGallery.resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004"))
    end
    it "should respond with error when is trying to create a consumer with wrong attributes" do
      stub_request(:post, RhoGallery.resource_url("testuser", "consumers")).
        to_return({:status => 422, :body => "login can't be blank"})
      new_cons = RhoGallery::Consumer.new({:name => "this is a name"})
      new_cons.save
      WebMock.should have_requested(:post, RhoGallery.resource_url("testuser", "consumers"))
      new_cons.errors.should == "login can't be blank"
    end
    it "should respond with error when is trying to update a consumer with wrong attributes" do
      stub_request(:put, RhoGallery.resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004")).
        to_return({:status => 422, :body => "login can't be blank"})
      consumer = RhoGallery::Consumer.find("4e6146d5bdd0c8048c000004")
      consumer.login = ""
      consumer.update
      WebMock.should have_requested(:put, RhoGallery.resource_url("testuser", "consumers/4e6146d5bdd0c8048c000004"))
      consumer.errors.should == "login can't be blank"
    end
  end
  
  context "Get and set consumers values" do
    before(:each) do
      @consumer = RhoGallery::Consumer.find("4e6146d5bdd0c8048c000004")
    end
    
    it "should get the consumer values and set new values" do
      @consumer.login.should == "some_login"
      @consumer.login = "the_new_login"
      @consumer.login.should == "the_new_login"
    end
    it "shouldn't raise an error when an set attribute doesn't exist, and should add it to attributes" do
      @consumer.some_attribute = "some value"
      @consumer.some_attribute.should == "some value"
    end
  end
end