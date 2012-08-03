# VulnDB HQ Ruby Gem [![Build Status](https://secure.travis-ci.org/securityroots/vulndbhq.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/securityroots/vulndbhq.png?travis)][gemnasium]

This gem provides a Ruby wrapper to the VulnDB HQ API (http://vulndbhq.com).

[travis]: http://travis-ci.org/securityroots/vulndbhq
[gemnasium]: https://gemnasium.com/securityroots/vulndbhq

## Installation

DANGER, WILL ROBINSON!

DANGER, WILL ROBINSON!

DANGER, WILL ROBINSON!

THIS GEM USES API v2 WHICH WILL BE AVAILABLE SOON

Add this line to your application's Gemfile:

    gem 'vulndbhq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vulndbhq


## Configuration

To provide your access credentials:

```ruby
require 'vulndbhq'

client = VulnDBHQ::client
client.host = 'https://you.vulndbhq.com'
client.user = 'your@email.com'
client.password = 'password'
```

Or provide configuration in line:

```ruby
client = VulnDBHQ::Client.new(host: 'https://your.vulndbhq.com', user: 'your@email.com', password: 'password')
```

## Usage examples

Return the all PrivatePage:

    client.private_pages

Return private pages containing `XSS`

    client.private_pages(q: 'XSS')

Get a PrivatePage by id:

```ruby
private_page = client.private_page(1)

puts private_page.name
puts private_page.content
```

See the [VulnDB HQ API docs][api] for the full list of available methods.

[api]: http://support.securityroots.com/vulndbhq_api_v2.html

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright (c) 2012 Daniel Martin, Security Roots Ltd.
See [LICENSE][license] for details.

[license]: https://github.com/securityroots/vulndbhq/blob/master/LICENSE

## Acknowledgements

This gem uses the [Faraday][faraday] gem for the HTTP layer and is inspired by the [Twitter][twitter] gem architecture.

[faraday]: http://rubygems.org/gems/faraday
[twitter]: http://rubygems.org/gems/twitter
