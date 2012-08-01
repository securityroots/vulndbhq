module VulnDBHQ
  module Error
    # Raised when VulnDBHQ returns the HTTP status code 424
    class FailedDependency < ClientError
      HTTP_STATUS_CODE = 424
    end
  end
end
