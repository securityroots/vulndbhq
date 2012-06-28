require 'faraday'
require 'vulndbhq/version'

module VulnDBHQ
  # Defines constants and methods related to configuration
  module Config
    # The Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    # The VulnDB HQ host if none is set
    DEFAULT_HOST = ENV['VULNDBHQ_HOST']

    # The VulnDB HQ user if none is set
    DEFAULT_USER = ENV['VULNDBHQ_USER']

    # The VulnDB HQ password if none is set
    DEFAULT_PASSWORD = ENV['VULNDBHQ_PASSWORD']


    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "VulnDB HQ Ruby Gem #{VulnDBHQ::Version}"

    # An array of valid keys in the options hash when configuring a {VulnDBHQ::Client}
    VALID_OPTIONS_KEYS = [
      :connection_options,
      :host,
      :user,
      :password,
      :user_agent
    ]
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.host = DEFAULT_HOST
      self.user = DEFAULT_USER
      self.password = DEFAULT_PASSWORD
      self.agent = DEFAULT_USER_AGENT
    end
  end
end