module VulnDBHQ
  module Response
    class RaiseClientError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = VulnDBHQ::Error::ClientError.errors[status_code]
        raise error_class.from_response_body(env[:body]) if error_class
      end

    end
  end
end
