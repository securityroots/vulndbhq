require 'spec_helper'

describe VulnDBHQ do

  describe '.respond_to?' do
    it "delegates to VulnDBHQ::Client" do
      VulnDBHQ.respond_to?(:private_pages).should be_true
    end
    it "takes an optional argument" do
      VulnDBHQ.respond_to?(:private_pages, true).should be_true
    end
  end

  describe ".client" do
    it "returns a VulnDBHQ::Client" do
      VulnDBHQ.client.should be_a VulnDBHQ::Client
    end
  end

  describe ".configure" do
    VulnDBHQ::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        VulnDBHQ.configure do |config|
          config.send("#{key}=", key)
        end
        VulnDBHQ.instance_variable_get("@#{key}").should eq key
      end
    end
  end

  VulnDBHQ::Configurable::CONFIG_KEYS.each do |key|
    it "has a default #{key.to_s.gsub('_', ' ')}" do
      VulnDBHQ.send(key).should eq VulnDBHQ::Default.options[key]
    end
  end
end