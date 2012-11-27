# Resto

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'resto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resto

## Usage

### Parse JSON
You must require the json lib from stdlib.

```ruby
require 'json'
require 'resto'
```

#### Faster CRuby or Rubinius JSON parsing
You can use another JSON gem if you want a faster JSON parser. This is how
you use the yajl gem with Resto.

```ruby
require 'yajl'
require 'resto'

Resto.configure do |config|
  config.json_decode = ->(json) { Yajl::Parser.parse(json) }
  config.json_encode = ->(hash) { Yajl::Encoder.encode(hash) }
end
```

#### Faster JRuby JSON parsing
If you use JRuby and want to parse JSON faster you can use the jrjackson gem.

```ruby
require 'jrjackson_r' # A JRuby library wrapping the JAVA jackson jars.
require 'resto'

Resto.configure do |config|
  config.json_decode = ->(json) { JrJackson::Json.parse(json) }
  config.json_encode = ->(hash) { JrJackson::Json.generate(hash) }
end
```

## References
* http://ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/Net/HTTP.html
* http://www.ruby-doc.org/stdlib-1.9.3/libdoc/uri/rdoc/URI.html
* http://ruby-doc.org/stdlib-1.9.3/libdoc/rexml/rdoc/REXML/Document.html
* http://www.germane-software.com/software/rexml/
* http://www.germane-software.com/software/rexml/docs/tutorial.html
* https://github.com/guyboertje/jrjackson - JSON parser in JRuby
* https://github.com/brianmario/yajl-ruby - JSON parser in MRI Ruby

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
