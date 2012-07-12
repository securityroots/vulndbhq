module VulnDBHQ
  # Defines constants and methods related to configuration
  module Configurable

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # An array of valid keys in the options hash when configuring a {VulnDBHQ::Client}
    CONFIG_KEYS = [
      :connection_options,
      :host,
    ]
    attr_accessor *CONFIG_KEYS

    AUTH_KEYS = [
      :user,
      :password
    ]
    attr_writer *AUTH_KEYS

    def self.keys
      @keys ||= CONFIG_KEYS + AUTH_KEYS
    end
  end
end