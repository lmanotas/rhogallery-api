module RhoGallery
  class API

    OPTIONS = {
      :username   => '',
      :api_token  => ''
    }

    def initialize(options = {})
      options = OPTIONS.merge(options)

      api_token  = options[:api_token] || ENV['HEROKU_API_KEY']
      @params = { username: options[:username], api_token: api_token }
    end

    def get_consumer(id)
      RhoGallery::Consumer.find(id, params: @params).to_json
    end

    def get_consumers
      RhoGallery::Consumer.find(:all, params: @params).to_json
    end

    def get_group(id);end

    def get_groups;end

  end

end