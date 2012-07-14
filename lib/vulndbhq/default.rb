module VulnDBHQ
  module Default

    def self.options
      Hash[VulnDBHQ::Configurable.keys.map{|key| [key, send(key)]}]
    end

    # The Faraday connection options if none is set
    def self.connection_options
      @connection_options ||= {
        :headers => {
          :accept => 'application/vnd.vulndbhq; v=2',
          :user_agent => "VulnDBHQ Ruby Gem #{VulnDBHQ::Version}"
        },
        :open_timeout => 5,
        :raw => true,
        :ssl => {:verify => false},
        :timeout => 10,
      }
    end

    # @note Faraday's middleware stack implementation is comparable to that of Rack middleware. The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
    # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
    # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
    def self.middleware
      @middleware ||= Faraday::Builder.new(
        &Proc.new do |builder|
          builder.use Faraday::Request::UrlEncoded # Convert request params as "www-form-urlencoded"
          builder.use VulnDBHQ::Response::ParseJson # Parse JSON response bodies using MultiJson
          builder.adapter Faraday.default_adapter # Set Faraday's HTTP adapter
        end
      )
    end

    # The VulnDB HQ host
    def self.host
      ENV['VULNDBHQ_HOST']
    end

    # The VulnDB HQ user if none is set
    def self.user
      ENV['VULNDBHQ_USER']
    end

    # The VulnDB HQ password if none is set
    def self.password
      ENV['VULNDBHQ_PASSWORD']
    end

  end
end
