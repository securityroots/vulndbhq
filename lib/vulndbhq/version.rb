module VulnDBHQ
  class Version #:nodoc:
    MAJOR = 0
    MINOR = 1
    TINY = 0
    PRE = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    # @return [String]
    def self.to_s
      STRING
    end
  end
end
