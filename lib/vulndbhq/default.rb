module VulnDBHQ
  module Default
    # The Faraday connection options if none is set
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "VulnDBHQ Ruby Gem #{VulnDBHQ::Version}"
      },
      :open_timeout => 5,
      :raw => true,
      :ssl => {:verify => false},
      :timeout => 10,
    } unless defined? CONNECTION_OPTIONS

    # The VulnDB HQ host if none is set
    HOST = ENV['VULNDBHQ_HOST'] unless defined? HOST

    # The VulnDB HQ user if none is set
    USER = ENV['VULNDBHQ_USER'] unless defined? USER

    # The VulnDB HQ password if none is set
    PASSWORD = ENV['VULNDBHQ_PASSWORD'] unless defined? PASSWORD
  end
end
