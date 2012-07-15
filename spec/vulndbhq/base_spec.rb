require 'spec_helper'

describe VulnDBHQ::Base do

  before do
    object = VulnDBHQ::Base.new(:id => 1)
    @base = VulnDBHQ::Base.store(object)
  end

  describe "#to_hash" do
    it "returns a hash" do
      @base.to_hash.should be_a Hash
      @base.to_hash[:id].should eq 1
    end
  end

  describe '.fetch' do
    it 'returns existing objects' do
      VulnDBHQ::Base.fetch(:id => 1).should be
      VulnDBHQ::Base.fetch(:id => 1).object_id.should eq(@base.object_id)
    end

    it "raises an error on objects that don't exist" do
      lambda {
        VulnDBHQ::Base.fetch(:id => 6)
      }.should raise_error(VulnDBHQ::IdentityMapKeyError)
    end
  end

  describe '.store' do
    it 'stores VulnDBHQ::Base objects' do
      object = VulnDBHQ::Base.new(:id => 4)
      VulnDBHQ::Base.store(object).should be_a VulnDBHQ::Base
    end
  end

  describe '.fetch_or_create' do
    it 'returns existing objects' do
      VulnDBHQ::Base.fetch_or_create(:id => 1).should be
      VulnDBHQ::Base.fetch(:id => 1).object_id.should eq(@base.object_id)
    end

    it 'creates new objects and stores them' do
      VulnDBHQ::Base.fetch_or_create(:id => 2).should be

      VulnDBHQ::Base.fetch(:id => 2).should be
    end
  end
end