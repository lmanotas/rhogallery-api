require File.join(File.dirname(__FILE__), 'spec_helper')

describe RhoGallery::Group do
  
  before(:each) do
    @spec_helpers = SpecHelpers.new
    @spec_helpers.stub_groups_methods
  end
  
  context "GET requests" do
    it "should send a GET request when is trying to find all the groups" do
      RhoGallery::Group.find_all
      WebMock.should have_requested(:get, "http://rhohub.local/rhogallery/api/v1/testuser/groups.json")
    end
    
    it "should make a GET request when is finding a group by ID" do
      RhoGallery::Group.find_by_id("4e6146d5bdd0c8048c000004")
      WebMock.should have_requested(:get, "http://rhohub.local/rhogallery/api/v1/testuser/groups/4e6146d5bdd0c8048c000004.json")
    end
  end
  
  context "Create update and delete actions" do
    it "should send a POST request when is creating a new group" do
      new_group = RhoGallery::Group.new({:name => "group_name"})
      new_group.create_new()
      WebMock.should have_requested(:post, "http://rhohub.local/rhogallery/api/v1/testuser/groups.json")
    end
    it "should send a DELETE request when is deleting a group" do
      group = RhoGallery::Group.find_by_id("4e6146d5bdd0c8048c000004")
      group.delete
      WebMock.should have_requested(:delete, "http://rhohub.local/rhogallery/api/v1/testuser/groups/4e6146d5bdd0c8048c000004.json")
    end
  end
  
  context "Get groups values" do
    it "should get al the group values" do
      group = RhoGallery::Group.find_by_id("4e6146d5bdd0c8048c000004")
      group.name.should == "koombea"
      group.id.should == "4e6146d5bdd0c8048c000004"
    end
  end
  
  context "Update method doesn't exist for groups" do
    it "should raise a NotMethod Exception when is trying to update a group" do
      group = RhoGallery::Group.find_by_id("4e6146d5bdd0c8048c000004")
      lambda { group.update }.should raise_error
    end
  end
end