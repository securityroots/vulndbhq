require 'vulndbhq/client'

module VulnDBHQ
  class << self

    include VulnDBHQ::Configurable

    def client
      VulnDBHQ::Client.new(options)
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