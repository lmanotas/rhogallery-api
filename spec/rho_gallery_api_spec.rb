require File.join(File.dirname(__FILE__), 'spec_helper')

describe RhoGalleryApi do
  context "RhoGalleryApi Credentials" do
    it "should set a user credentials with credentuals method" do
      RhoGalleryApi.credentials = {:username => "some_username", :token => "some_rhogallery_token"}
      ENV['rhogallery_username'].should == "some_username"
      ENV['rhogallery_token'].should == "some_rhogallery_token"
    end
    it "should not set and raise an error when is trying to set invalid credentials" do
      lambda { RhoGalleryApi.credentials = {} }.should raise_error
    end
  end
end