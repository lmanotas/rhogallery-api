RhoGallery API
==================
##Getting Started

This is a ruby interface to connect with the rhohub rhogallery api. 

	$ gem install rhogallery

	require 'rhogallery'

##RhoGallery Credentials

First of all you need to set your RhoGallery credentials (username and rhogallery token):

	RhoGallery.credentials = {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOHUB_TOKEN}

Also, you can see your credentials any time with:

	RhoGallery.credentials
	=> {:username => YOUR_RHOHUB_USERNAME, :token => YOUR_RHOHUB_TOKEN}

##RhoGallery Resources

Then you have two classes that you can work with: `RhoGallery::Consumer` and `RhoGallery::Group`

	RhoGallery # Rhogallery main module
	
	RhoGallery::Consumer 
	RhoGallery::Group
		
	  create(data, options) 	# create a new consumer/group
	  update(data, options)     # use this method to update data
	  delete(data, options)     # to delete a consumer/group

* data: consumer or group data, for example: name, cell, login, email. By default takes the data hash takes the attributes 
	added when is creating the instance ( RhoGallery::Group.new( {:name => "some group name" }) ).
		
* options: credentials options, you can use a diferent credential in any time. 

##Get Consumers and Groups

You can get all your consumers and groups like this:

	RhoGallery::Consumer.find_all
	=> [{"name":"John Doe","devices":["ios","android","blackberry"],"deactivated_id":null,
			"created_at":"2011-01-14T17:49:42Z","cell":"+555555",
			"updated_at":"2011-06-21T21:14:12Z",
			"tags":"","deleted":false,"password":"f3df5b5853c26e9b664262a5f590df8d",
			"login":"john","invited":true,
			"email":"john@doe.com","active":true}]
	
	RhoGallery::Group.find_all
	=> [{"name":"rhomobile","created_at":"2011-01-14T15:37:42Z","updated_at":"2011-01-14T15:37:42Z",
			"id":"4d306dc697fcc274a6000009","active":true},
			{"name":"koombea","created_at":"2011-05-27T22:24:05Z","updated_at":"2011-05-27T22:24:05Z",
			"id":"4de024851189870001000001","active":true}]

or if you want to find a consumer/group by id you can do this:

	RhoGallery::Consumer.find("some_consumer_id")
	=> {"name":"John Doe","devices":["ios","android","blackberry"],"deactivated_id":null,
			"created_at":"2011-01-14T17:49:42Z","cell":"+555555",
			"updated_at":"2011-06-21T21:14:12Z",
			"tags":"","deleted":false,"password":"f3df5b5853c26e9b664262a5f590df8d",
			"login":"john","invited":true,
			"email":"john@doe.com","active":true}

	RhoGallery::Group.find("some_group_id")
	=> {"name":"rhomobile","created_at":"2011-01-14T15:37:42Z","updated_at":"2011-01-14T15:37:42Z",
			"id":"4d306dc697fcc274a6000009","active":true}

##Create new consumer/group

You can create new groups and consumers with your own attributes and then save it as a new consumer/group. (returns true or false).

	consumer = RhoGallery::Consumer.new({
		:login => "some_login", :name => "some name", :cell => "+55555", :email => "email@email.com"
	})
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:login => "some_login", :name => "some name", :cell => "+55555", :email => "email@email.com"}>
	
	consumer.save
	=> true
	
	group = RhoGallery::Group.new({:name => "new_group_name"})
	=> #<RhoGallery::Group:0x1018881b6 @attributes={:name=>"new_group_name"}>
	
	group.save
	=> true

or send the data directly when `create` method is called

	consumer = RhoGallery::Consumer.new
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"+55555", :email=>"email@email.com", 
			:login=>"some_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>
			
	consumer.create({
		:login => "some_login", :name => "some name", :cell => "+55555", :email => "email@email.com"
	})
	=> true

##Update Method

Also you can update your consumers and groups fields with the `update`

	consumer = RhoGallery::Consumer.find("4e60ffd4bdd0c8048c000001")
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"some_cell_phone", :invited=>false, :email=>"email@email.com", 
			:login=>"some_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>

	consumer.update({:login => "new_login", :cell => "new cell phone"})
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"new cell phone", :invited=>false, :email=>"email@email.com", 
			:login=>"new_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>

##Delete a Consumer or Group

and you can delete it too :)

	consumer = RhoGallery::Consumer.find("4e60ffd4bdd0c8048c000001")
	=> #<RhoGallery::Consumer:0x1018881a8 @attributes={:cell=>"new cell phone", :invited=>false, :email=>"email@email.com", 
			:login=>"new_login",:tags=>"", :password=>"", :name=>"hello", :id=>"4e60ffd4bdd0c8048c000001"}>

	consumer.delete
	=> true

##See Errors

You can see the errors when the `create` and `update` methods return false, using the errors method. For example:

	group = RhoGallery::Group.new
	=> #<RhoGallery::Group:0x1018881c7 @attributes={:name => ""}>
	group.save
	=> false
	
	group.errors
	=> "Name can't be blank"

##Meta
Created and maintained by [Luis Manotas](https://github.com/lmanotas), [Mario Tatis](https://github.com/mariotatis) and [Lars Burgess](https://github.com/larsburgess).

Released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).