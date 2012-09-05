require 'spec_helper'

describe VulnDBHQ::PublicPage do

  it "loads :name and :content from the server's JSON body" do
    stub_get('/api/public_pages/1').
    to_return(:status => 200,
      :body => "{\"content\":\"#[Title]#\\r\\nThis is my Public Page\\r\\n\\r\\n\",\"id\":1,\"name\":\"MyPublicPage\"}",
      :headers => {'Content-Type' => 'application/json; charset=utf-8'})
    client = VulnDBHQ::Client.new(:host => TEST_ENDPOINT)

    public_page = client.public_page(1)
    public_page.should be
    public_page.should be_a(VulnDBHQ::PublicPage)
    public_page.name.should eq('MyPublicPage')
    public_page.content.should eq("#[Title]#\r\nThis is my Public Page\r\n\r\n")
  end

  it "loads a collection of PublicPages" do
    stub_get('/api/public_pages').
    to_return(:status => 200,
      :body => "[{\"content\":\"#[Title]#\\r\\nThis is my Public Page\\r\\n\\r\\n\",\"id\":1,\"name\":\"MyPublicPage1\"}," +
                  "{\"content\":\"#[Title]#\\r\\nThis is another Public Page\\r\\n\\r\\n\",\"id\":2,\"name\":\"MyPublicPage2\"}]",
      :headers => {'Content-Type' => 'application/json; charset=utf-8'})
    client = VulnDBHQ::Client.new(:host => TEST_ENDPOINT)

    collection = client.public_pages
    collection.should be
    collection.length.should eq(2)
    collection.last.name.should eq('MyPublicPage2')
  end
end