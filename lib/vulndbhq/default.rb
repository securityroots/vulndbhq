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
