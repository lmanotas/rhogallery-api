require File.join(File.dirname(__FILE__), 'spec_helper')

describe RhoGallery do
  context "RhoGallery Credentials" do
    it "should set a user credentials with credentuals method" do
      RhoGallery.credentials = {:username => "some_username", :token => "some_rhogallery_token"}
      ENV['rhogallery_username'].should == "some_username"
      ENV['rhogallery_token'].should == "some_rhogallery_token"
    end
    it "should not set and raise an error when is trying to set invalid credentials" do
      lambda { RhoGallery.credentials = {} }.should raise_error
      ENV['rhogallery_username'] = nil
      ENV['rhogallery_token'] = nil
      lambda { RhoGallery.credentials }.should raise_error
    end
  end
end