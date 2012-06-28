module VulnDBHQ
  class Version #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY = 1
    PRE = "beta"

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    # @return [String]
    def self.to_s
      STRING
    end
  end
end
