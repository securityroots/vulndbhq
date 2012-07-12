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
    include VulnDBHQ::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [VulnDBHQ::Client]
    def initialize(options={})
      VulnDBHQ::Configurable.keys.each do |key|
        instance_variable_set("@#{key}", options[key] || VulnDBHQ.options[key])
      end
    end

    # Returns the collection of VulnDBHQ::PrivatePage for the account

    # @see http://support.securityroots.com/vulndbhq_api_v2.html#model-private-page
    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [Array<VulnDBHQ::PrivatePage>] PrivatePages in the account associated with this user.
    # @param options [Hash] A customizable set of options.
    # @option options [nil] no options are supported yet.
    # @example Return the private pages for the account
    # VulnDBHQ.private_pages
    def private_pages(options={})
      # response = get("/api/private_pages", options)
      # collection_from_array(response[:body], VulnDBHQ::PrivatePage)
    end
  end
end