# SRGS

A tool for building srgs documents

## Installation

Add this line to your application's Gemfile:

    gem 'srgs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install srgs

## Usage

Here's an example file. It will be documented better later

[This](http://msdn.microsoft.com/en-us/library/hh361653(v=office.14).aspx) is a good
reference on how srgs grammars work.

```ruby
require 'srgs'

module WeatherGrammar
  include Srgs::DSL

  extend self

  grammar 'topLevel' do
    private_rule 'riseset' do
      one_of do
        item 'rise'
        item 'set'
      end
    end

    private_rule 'days' do
      one_of do
        item 'today'
        item 'tomorrow'
        item 'currently'
      end
    end

    public_rule 'weather' do
      item 'Mycroft what is the weather'
      reference 'days'
      tag 'out.day=rules.days;'
    end

    public_rule 'days' do
      item 'Mycroft when is sun'
      reference 'riseset'
      tag 'out.rise_or_set=rules.riseset;'
      reference 'days'
      tag 'out.day=rules.days;'
    end

    public_rule 'topLevel' do
      one_of do
        reference_item 'weather'
        reference_item 'days'
      end
    end
  end
end
```

Running that will print to console the corresponding xml.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
