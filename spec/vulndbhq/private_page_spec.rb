require 'spec_helper'

describe VulnDBHQ::PrivatePage do

  it "loads :name and :content from the server's JSON body" do
    stub_get('/api/private_pages/1').
    to_return(:status => 200,
      :body => "{\"content\":\"#[Title]#\\r\\nThis is my Private Page\\r\\n\\r\\n\",\"id\":1,\"name\":\"MyPrivatePage\"}",
      :headers => {'Content-Type' => 'application/json; charset=utf-8'})
    client = VulnDBHQ::Client.new(host: TEST_ENDPOINT)

    private_page = client.private_page(1)
    private_page.should be
    private_page.should be_a(VulnDBHQ::PrivatePage)
    private_page.name.should eq('MyPrivatePage')
    private_page.content.should eq("#[Title]#\r\nThis is my Private Page\r\n\r\n")
  end

  it "loads a collection of PrivatePages" do
    stub_get('/api/private_pages').
    to_return(:status => 200,
      :body => "[{\"content\":\"#[Title]#\\r\\nThis is my Private Page\\r\\n\\r\\n\",\"id\":1,\"name\":\"MyPrivatePage1\"}," +
                  "{\"content\":\"#[Title]#\\r\\nThis is another Private Page\\r\\n\\r\\n\",\"id\":2,\"name\":\"MyPrivatePage2\"}]",
      :headers => {'Content-Type' => 'application/json; charset=utf-8'})
    client = VulnDBHQ::Client.new(host: TEST_ENDPOINT)

    collection = client.private_pages
    collection.should be
    collection.length.should eq(2)
    collection.last.name.should eq('MyPrivatePage2')
  end
end