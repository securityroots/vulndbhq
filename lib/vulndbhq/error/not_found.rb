module VulnDBHQ
  module Error
    # Raised when VulnDBHQ returns the HTTP status code 404
    class NotFound < ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end