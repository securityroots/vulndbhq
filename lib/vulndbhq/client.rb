require 'faraday'
require 'vulndbhq/configurable'
require 'vulndbhq/default'
require 'vulndbhq/version'

module VulnDBHQ
  # Wrapper for the VulnDB HQ REST API
  #
  # @note All methods have been separated into modules as described in the API docs
  # @see http://support.securityroots.com
  class Client
    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [VulnDBHQ::Client]
    def initialize(options={})
      VulnDBHQ::Configurable.keys.each do |key|
        instance_variable_set("@#{key}", options[key] || VulnDBHQ::Default.const_get(key.to_s.upcase.to_sym))
      end
    end

    # Returns the requesting user if authentication was successful, otherwise raises {VulnDBHQ::Error::Unauthorized}
    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [VulnDBHQ::User] The authenticated user.
    # @param options [Hash] A customizable set of options.
    # @example Return the requesting user if authentication was successful
    # VulnDBHQ.verify_credentials
    def verify_credentials(options={})
      response = get("/api/account/verify_credentials.json", options)
      VulnDBHQ::User.from_response(response)
    end
    alias current_user verify_credentials
  end
end