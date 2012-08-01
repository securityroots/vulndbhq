require 'vulndbhq/identity_map'

module VulnDBHQ

  # Provides some common facilities for all VulnDBHQ objects including the
  # ability to store attributes and to use an identity map to prevent
  # re-loading the same object multiple times.
  class Base
    attr_reader :attrs
    alias to_hash attrs

    @@identity_map = IdentityMap.new

    # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
    #
    # @overload self. attr_reader(attr)
    # @param attr [Symbol]
    # @overload self. attr_reader(attrs)
    # @param attrs [Array<Symbol>]
    def self.attr_reader(*attrs)
      attrs.each do |attribute|
        class_eval do
          define_method attribute do
            @attrs[attribute.to_sym]
          end
        end
      end
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def initialize(attrs={})
      self.update(attrs)
    end

    # Update the attributes of an object
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def update(attrs)
      @attrs ||= {}
      @attrs.update(attrs)
      self
    end

    # Creates a new object and stores it in the identity map.
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def self.create(attrs={})
      object = self.new(attrs)
      self.store(object)
    end

    # Retrieves an object from the identity map.
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def self.fetch(attrs)
      @@identity_map[self] ||= {}
      if object = @@identity_map[self][Marshal.dump(attrs)]
        return object
      end

      return yield if block_given?
      raise VulnDBHQ::IdentityMapKeyError, 'key not found'
    end

    # Stores an object in the identity map.
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def self.store(object)
      @@identity_map[self] ||= {}
      @@identity_map[self][Marshal.dump(object.attrs)] = object
    end

    # Returns a new object based on the response hash
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def self.from_response(response={})
      self.fetch_or_create(response[:body])
    end

    # Retrieves an object from the identity map, or stores it in the
    # identity map if it doesn't already exist.
    #
    # @param attrs [Hash]
    # @return [VulnDBHQ::Base]
    def self.fetch_or_create(attrs={})
      self.fetch(attrs) do
        self.create(attrs)
      end
    end
  end
end
