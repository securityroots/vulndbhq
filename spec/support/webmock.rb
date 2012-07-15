TEST_ENDPOINT = 'https://user.vulndbhq.com'

def stub_get(path, endpoint=TEST_ENDPOINT)
  stub_request(:get, endpoint + path)
end