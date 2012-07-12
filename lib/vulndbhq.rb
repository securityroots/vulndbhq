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

    def options
      @options = {}
      VulnDBHQ::Configurable.keys.each do |key|
        @options[key] = instance_variable_get("@#{key}")
      end
      @options
    end

    def reset!
      VulnDBHQ::Configurable.keys.each do |key|
        instance_variable_set("@#{key}", VulnDBHQ::Default.options[key])
      end
      self
    end
    alias setup reset!

  end
end

VulnDBHQ.setup