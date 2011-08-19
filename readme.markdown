# Resto [![Stillmaintained](http://stillmaintained.com/unders/resto.png)](http://stillmaintained.com/unders/resto)

* http://github.com/unders/resto
* [![Build Status](http://travis-ci.org/unders/resto.png)](http://travis-ci.org/unders/resto)
* [GemTesters](http://test.rubygems.org/gems/resto)

## Description:

Resto aims to simplify working with web services.
Documentation is available at [rubydoc](http://rubydoc.info/gems/resto)

## Compatibility

Ruby version 1.9.2 and 1.8.7.

[GemTesters](http://test.rubygems.org/gems/resto) has
 more information on which platform the Gem is tested.

## Install

Install as a gem:

    gem install resto

### How to test the installed Gem

    gem install rubygems-test
    gem test resto

For more info see: [GemTesters](http://test.rubygems.org/)

## Getting Started

### Working with the [Gists API](http://developer.github.com/v3/gists/)

#### 1. Test the API

    Resto.url('https://api.github.com/users/unders/gists').format(:json).
      params(:per_page => 1).get!

and the output will look like [this](https://github.com/unders/resto/raw/master/example/1_gists_output.txt).

## Examples

To run all [examples](https://github.com/unders/resto/tree/master/example), rename:
[key_setup.rb.your_keys](https://github.com/unders/resto/tree/master/example/key_setup.rb.your_keys)
to key_setup.rb and add your API keys.


## License:

(The MIT License)

Copyright (c) 2011 Anders Törnqvist

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
