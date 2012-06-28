require 'vulndbhq/client'

module VulnDBHQ
  class << self
    include VulnDBHQ::Configurable

    def client
      VulnDBHQ::Client.new(options)
    end

    # Delegate to a VulnDBHQ::Client
  end
end

VulnDBHQ.setup