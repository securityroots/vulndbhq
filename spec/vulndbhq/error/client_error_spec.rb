require 'spec_helper'

describe VulnDBHQ::Error::ClientError do
  before do
    @client = VulnDBHQ::Client.new(:host => TEST_ENDPOINT)
  end

  VulnDBHQ::Error::ClientError.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        body_message = '{"message":"Client Error"}'
        stub_get("/api/private_pages/1").
          to_return(:status => status, :body => body_message)
      end
      it "raises #{exception.name}" do
        lambda do
          @client.private_page(1)
        end.should raise_error(exception)
      end
    end
  end
end