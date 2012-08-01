require 'spec_helper'

describe VulnDBHQ do
  after do
    VulnDBHQ.reset!
  end

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
    context "when the options don't change" do
      it "caches the client" do
        VulnDBHQ.client.should eq VulnDBHQ.client
      end
    end
    context "when the options change" do
      it "busts the cache" do
        client1 = VulnDBHQ.client
        VulnDBHQ.configure do |config|
          config.host = TEST_ENDPOINT
        end
        client2 = VulnDBHQ.client
        client1.should_not eq client2
      end
    end
  end

  describe ".configure" do
    VulnDBHQ::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        VulnDBHQ.configure do |config|
          config.send("#{key}=", key)
        end
        VulnDBHQ.instance_variable_get(:"@#{key}").should eq key
      end
    end
  end

  VulnDBHQ::Configurable::CONFIG_KEYS.each do |key|
    it "has a default #{key.to_s.gsub('_', ' ')}" do
      VulnDBHQ.send(key).should eq VulnDBHQ::Default.options[key]
    end
  end
end