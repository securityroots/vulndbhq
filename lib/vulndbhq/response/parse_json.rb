module VulnDBHQ
  module Response
    class ParseJson < Faraday::Response::Middleware

      def parse(body)
        case body
        when ''
          nil
        when 'true'
          true
        when 'false'
          false
        else
          MultiJson.load(body, :symbolize_keys => true)
        end
      end

      def on_complete(env)
        if respond_to?(:parse)
	    # only call the parse routine if the response is json
            if env[:response_headers].has_key?("content-type") && env[:response_headers]["content-type"].include?("json")
		env[:body] = parse(env[:body]) unless [204, 304, 404].include?(env[:status])
            end
        end
      end

    end
  end
end