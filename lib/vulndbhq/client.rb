require 'faraday'
require 'multi_json'

require 'vulndbhq/base'
require 'vulndbhq/configurable'
require 'vulndbhq/default'
require 'vulndbhq/error'
require 'vulndbhq/private_page'
require 'vulndbhq/public_page'
require 'vulndbhq/response/parse_json'
require 'vulndbhq/response/raise_client_error'
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
        instance_variable_set(:"@#{key}", options[key] || VulnDBHQ.instance_variable_get(:"@#{key}"))
      end
    end


    # ************************************************************* PrivatePage

    # Returns a private page
    #
    # @see http://support.securityroots.com/vulndbhq_api_v2.html#model-private-page

    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [VulnDBHQ::PrivatePage] The requested messages.
    # @param id [Integer] A VulnDB HQ private page ID.
    # @param options [Hash] A customizable set of options.
    # @example Return the private page with the id 87
    # VulnDBHQ.private_page(87)
    def private_page(id, options={})
      response = get("/api/private_pages/#{id}", options)
      VulnDBHQ::PrivatePage.from_response(response)
    end

    # Returns the collection of VulnDBHQ::PrivatePage for the account
    #
    # @see http://support.securityroots.com/vulndbhq_api_v2.html#model-private-page
    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [Array<VulnDBHQ::PrivatePage>] PrivatePages in the account associated with this user.
    # @param options [Hash] A customizable set of options.
    # @option options [nil] no options are supported yet.
    # @example Return the private pages for the account
    # VulnDBHQ.private_pages
    def private_pages(options={})
      response = get("/api/private_pages", options)
      collection_from_array(response[:body], VulnDBHQ::PrivatePage)
    end


    # ************************************************************** PublicPage

    # Returns a public page
    #
    # @see http://support.securityroots.com/vulndbhq_api_v2.html#model-public-page

    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [VulnDBHQ::PublicPage] The requested messages.
    # @param id [Integer] A VulnDB HQ private page ID.
    # @param options [Hash] A customizable set of options.
    # @example Return the public page with the id 87
    # VulnDBHQ.public_page(87)
    def public_page(id, options={})
      response = get("/api/public_pages/#{id}", options)
      VulnDBHQ::PublicPage.from_response(response)
    end

    # Returns the collection of VulnDBHQ::PublicPage available at the moment
    #
    # @see http://support.securityroots.com/vulndbhq_api_v2.html#model-public-page
    # @authentication_required Yes
    # @raise [VulnDBHQ::Error::Unauthorized] Error raised when supplied user credentials are not valid.
    # @return [Array<VulnDBHQ::PublicPage>] PrivatePages in the account associated with this user.
    # @param options [Hash] A customizable set of options.
    # @option options [nil] no options are supported yet.
    # @example Return the public pages available in the system
    # VulnDBHQ.public_pages
    def public_pages(options={})
      response = get("/api/public_pages", options)
      collection_from_array(response[:body], VulnDBHQ::PublicPage)
    end


    # ********************************************************* Support methods

    # Perform an HTTP GET request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    # Check whether credentials are present
    #
    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    private

    def collection_from_array(array, klass)
      array.map do |element|
        klass.fetch_or_create(element)
      end
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@host, @connection_options.merge(:builder => @middleware))
    end

    # Perform an HTTP request
    def request(method, path, params, options)
      uri = options[:host] || @host
      uri = URI(uri) unless uri.respond_to?(:host)
      uri += path
      request_headers = {}
      if self.credentials?
        # When posting a file, don't sign any params
        # signature_params = if [:post, :put].include?(method.to_sym) && params.values.any?{|value| value.is_a?(File) || (value.is_a?(Hash) && (value[:io].is_a?(IO) || value[:io].is_a?(StringIO)))}
        #   {}
        # else
        #   params
        # end
        # authorization = SimpleOAuth::Header.new(method, uri, signature_params, credentials)
        # request_headers[:authorization] = authorization.to_s
        connection.basic_auth(credentials[:user], credentials[:password])
      end
      connection.url_prefix = options[:host] || @host
      connection.run_request(method.to_sym, path, nil, request_headers) do |request|
        unless params.empty?
          case request.method
          when :post, :put
            request.body = params
          else
            request.params.update(params)
          end
        end
        yield request if block_given?
      end.env
    rescue Faraday::Error::ClientError
      raise VulnDBHQ::Error::ClientError
    end

    # Credentials hash
    #
    # @return [Hash]
    def credentials
      {
        :user => @user,
        :password => @password
      }
    end
  end
end