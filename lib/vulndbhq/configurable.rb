module VulnDBHQ
  # Defines constants and methods related to configuration
  module Configurable

    # An array of valid keys in the options hash when configuring a {VulnDBHQ::Client}
    CONFIG_KEYS = [
      :connection_options,
      :host,
      :middleware
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

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    def cache_key
      options.hash
    end

    def reset!
      VulnDBHQ::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", VulnDBHQ::Default.options[key])
      end
      self
    end
    alias setup reset!

    private
    def options
      Hash[VulnDBHQ::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end