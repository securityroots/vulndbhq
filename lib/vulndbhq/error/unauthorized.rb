module VulnDBHQ
  module Error
    # Raised when VulnDBHQ returns the HTTP status code 401
    class Unauthorized < ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end
