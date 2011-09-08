Rhogallery API
==================
##Instaling

This is a ruby interface to connect with the rhohub rhogallery api. 

	$ gem install rhogallery

	require 'rhogallery-api'

##Rhogallery Credentials

First of all you need to set your rhogallery credentials (username and rhogallery token):

	RhoGalleryApi.credentials = {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOGALLERY_TOKEN}

Also, you can see your credentials any time with:

	RhoGalleryApi.credentials
	=> {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOHUB_RHOGALLERY_TOKEN}

##Rhogallery Resources

Then you have two classes that you can work with: RhoGallery::Consumer and RhoGallery::Group

	RhoGalleryApi # Rhogallery Api Defaults configurations
	
	RhoGallery::Consumer 
	RhoGallery::Group
		
	  create_new(data, options) #create a new consumer/group
	  update(data, options)     #use this method to update data
	  delete(data, options)     #to delete a consumer/group

	  #data: consumer or group data, for example: name, cell, login, email. By default takes the data hash takes the attributes 
	  #added when is creating the instance ( RhoGallery::Group.new( {:name => "some group name" }) ).
		
	  #options: credentials options, you can use a diferent credential in any time. 

##Get Consumers and Groups

You can get all your consumers and groups like this:

	RhoGallery::Consumer.find_all
	=> [{"name":"John Doe","devices":["ios","android","blackberry"],"deactivated_id":null,
			"created_at":"2011-01-14T17:49:42Z","cell":"+555555",
			"updated_at":"2011-06-21T21:14:12Z",
			"admin_id":"4d2c9e31f3fda97a3e000006",
			"account_id":null,"tags":"","deleted":false,"password":"f3df5b5853c26e9b664262a5f590df8d",
			"login":"john","invited":true,
			"gallery_id":null,"email":"john@doe.com","active":true}]
	
	RhoGallery::Group.find_all
	=> [{"name":"rhomobile","created_at":"2011-01-14T15:37:42Z","updated_at":"2011-01-14T15:37:42Z",
			"admin_id":"4d2e11dae433c241e9000001","id":"4d306dc697fcc274a6000009","active":true},
			{"name":"koombea","created_at":"2011-05-27T22:24:05Z","updated_at":"2011-05-27T22:24:05Z",
			"admin_id":"4d2e11dae433c241e9000001","id":"4de024851189870001000001","active":true}]

or if you want to find a consumer/group by id you can:

	RhoGallery::Consumer.find_by_id("some_consumer_id")
	=> {"name":"John Doe","devices":["ios","android","blackberry"],"deactivated_id":null,
			"created_at":"2011-01-14T17:49:42Z","cell":"+555555",
			"updated_at":"2011-06-21T21:14:12Z",
			"admin_id":"4d2c9e31f3fda97a3e000006",
			"account_id":null,"tags":"","deleted":false,"password":"f3df5b5853c26e9b664262a5f590df8d",
			"login":"john","invited":true,
			"gallery_id":null,"email":"john@doe.com","active":true}

	RhoGallery::Group.find_by_id("some_group_id")
	=> {"name":"rhomobile","created_at":"2011-01-14T15:37:42Z","updated_at":"2011-01-14T15:37:42Z",
			"admin_id":"4d2e11dae433c241e9000001","id":"4d306dc697fcc274a6000009","active":true}

##Create new consumer/group

You can create new groups and consumers with your own attributes and then saved as a new consumer/group.

	consumer = RhoGallery::Consumer.new({
		:login => "some_login", :name => "some name", :cell => "+55555", :email => "email@email.com"
	})

	consumer.create_new
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"", :email=>"", :login=>"",:tags=>"", :password=>"", :name=>""}>
	
	group = RhoGallery::Group.new({:name => "new_group_name"})
	
	group.create_new
	=> #<RhoGallery::Group:0x1018881b6 @attributes={:name=>""}>

or send it the data on the 'create_new' method is called

	consumer = RhoGallery::Consumer.new
	consumer.create_new({
		:login => "some_login", :name => "some name", :cell => "+55555", :email => "email@email.com"
	})
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"+55555", :email=>"email@email.com", 
			:login=>"some_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>

##Update Method

Also you can update your consumers and groups fields

	consumer.update({:login => "new_login", :cell => "new cell phone"})
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"new cell phone", :invited=>false, :email=>"email@email.com", 
			:login=>"new_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>

##Delete a Consumer or Group

and you can delete it too :)

	consumer.delete
	=> true

##See Errors

you can see the errors when something happend with :errors method, it should return an comma separated string with all the errors

	group = RhoGallery::Group.new
	=> #<RhoGallery::Group:0x1018881c7 @attributes={:name => ""}>
	group.create_new
	=> false
	
	group.errors
	=> "Name can't be blank"