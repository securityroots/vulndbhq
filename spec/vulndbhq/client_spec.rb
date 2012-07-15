require 'spec_helper'

describe VulnDBHQ::Client do

  pending "catches Faraday errors"
  # it "catches Faraday errors" do
  #   subject.stub!(:connection).and_raise(Faraday::Error::ClientError.new("Oups"))
  #   lambda do
  #     subject.request(:get, "/path", {}, {})
  #   end.should raise_error(VulnDBHQ::Error::ClientError, "Oups")
  # end

end