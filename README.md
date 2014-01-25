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

    public_rule 'sun' do
      item 'Mycroft when is sun'
      reference 'riseset'
      tag 'out.rise_or_set=rules.riseset;'
      reference 'days'
      tag 'out.day=rules.days;'
    end

    public_rule 'topLevel' do
      one_of do
        reference_item 'weather'
        reference_item 'sun'
      end
    end
  end
end
```

Running that will print to console the corresponding xml.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<grammar xmlns="http://www.w3.org/2001/06/grammar" xml:lang="en-US" root="toplevel" tag-format="semantics/1.0" version="1.0">
   <rule id="toplevel">
      <one-of>
         <item>
            <ruleref uri="#weather" />
         </item>
         <item>
            <ruleref uri="#sun" />
         </item>
      </one-of>
   </rule>
   <rule id="weather" scope="public">
      <item>Mycroft what is the weather</item>
      <ruleref uri="#days" />
      <tag>out.day=rules.days;</tag>
   </rule>
   <rule id="sun" scope="public">
      <item>Mycroft When is sun</item>
      <ruleref uri="#riseset" />
      <tag>out.rise_or_set=rules.riseset;</tag>
      <ruleref uri="#days" />
      <tag>out.day=rules.days;</tag>
   </rule>
   <rule id="days" scope="private">
      <one-of>
         <item>today</item>
         <item>tomorrow</item>
         <item>currently</item>
      </one-of>
   </rule>
   <rule id="riseset" scope="private">
      <one-of>
         <item>rise</item>
         <item>set</item>
      </one-of>
   </rule>
</grammar>
```

## References

* [Speech Recognition Grammar Specification Version 1.0](http://www.w3.org/TR/speech-grammar/#S4.13)
* [SRGS Grammar XML Reference](http://msdn.microsoft.com/en-us/library/hh361653.aspx)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
