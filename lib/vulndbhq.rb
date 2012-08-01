require 'vulndbhq/client'

module VulnDBHQ
  class << self

    include VulnDBHQ::Configurable

    def client
      if @client && @client.cache_key == options.hash
        @client
      else
        @client = VulnDBHQ::Client.new(options)
      end
    end

    # Delegate to a VulnDBHQ::Client
    def respond_to?(method, include_private=false)
      self.client.respond_to?(method, include_private) || super
    end

    private
    def method_missing(method, *args, &block)
      return super unless self.client.respond_to?(method)
      self.client.send(method, *args, &block)
    end

  end
end

VulnDBHQ.setup