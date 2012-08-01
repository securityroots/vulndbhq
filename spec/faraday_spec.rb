require 'spec_helper'

describe 'Faraday response' do

  context "for valid object" do
    let(:middleware) { VulnDBHQ::Response::ParseJson.new(lambda{|env| Faraday::Response.new(env)}) }

    def process(body, content_type = nil)
      env = {:body => body, :request_headers => Faraday::Utils::Headers.new}
      env[:request_headers]['content-type'] = content_type if content_type
      middleware.call(env)
    end    

    it "parses response body (JSON) into a Hash" do
      response = process('{"a":1,"b":"dos"}', 'application/json')
      response.body.should be_a_kind_of(Hash)
      response.body.keys.should include(:a)
      response.body.keys.should include(:b)
      response.body[:b].should eq('dos')
    end
  end
end