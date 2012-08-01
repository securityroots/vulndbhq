module VulnDBHQ
  module Error
    # Raised when VulnDBHQ returns a 4xx HTTP status code or there's an error in Faraday
    class ClientError < Base

      # Create a new error from an HTTP environment
      #
      # @param body [Hash]
      # @return [VulnDBHQ::Error]
      def self.from_response_body(body)
        new(parse_error(body))
      end

      private

      def self.parse_error(body)
        if body.nil?
          ''
        elsif body[:message]
          body[:message]
        end
      end

    end
  end
end
