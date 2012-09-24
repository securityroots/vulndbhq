require 'spec_helper'

describe VulnDBHQ::Client do

  pending "catches Faraday errors"
  # it "catches Faraday errors" do
  #   subject.stub!(:connection).and_raise(Faraday::Error::ClientError.new("Oups"))
  #   lambda do
  #     subject.request(:get, "/path", {}, {})
  #   end.should raise_error(VulnDBHQ::Error::ClientError, "Oups")
  # end
  pending "catches MultiJson::DecodeError errrors"
  # it "catches MultiJson::DecodeError errors" do
  #   subject.stub!(:connection).and_raise(MultiJson::DecodeError.new("unexpected token", [], "<!DOCTYPE html>"))
  #   lambda do
  #     subject.request(:get, "/path")
  #   end.should raise_error(Twitter::Error::DecodeError, "unexpected token")
  # end
  pending "raises an exception if no host endpoint has been provided"
end