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

[This](http://msdn.microsoft.com/en-us/library/hh361653.aspx) is a good
reference on how srgs grammars work.

In the future, I plan to create a dsl for this but for now this is how it works.
```ruby
require 'srgs'

grammar = Srgs::Grammar.new

sunriseset = Srgs::Rule.new('riseset')
sunriseset_choices = Srgs::OneOf.new << Srgs::Item.new('rise') << Srgs::Item.new('set')
sunriseset << sunriseset_choices
sunriseset.scope = 'private'

sunriseset_ref = Srgs::RuleRef.new(sunriseset)

days = Srgs::Rule.new('days')
days_choices = Srgs::OneOf.new << Srgs::Item.new('today') << Srgs::Item.new('tomorrow') << Srgs::Item.new('currently')
days << days_choices
days.scope = 'private'

days_ref = Srgs::RuleRef.new(days)

weather = Srgs::Rule.new('weather')
sun = Srgs::Rule.new('sun')

question1 = Srgs::Item.new("Mycroft what is the weather");
question2 = Srgs::Item.new("Mycroft When is sun");

weather << question1
weather << days_ref
weather << Srgs::Tag.new("out.day=rules.days;")
weather.scope = 'public'

sun << question2
sun << sunriseset_ref
sun << Srgs::Tag.new("out.rise_or_set=rules.riseset;")
sun << days_ref
sun << Srgs::Tag.new("out.day=rules.days;")
sun.scope = 'public'

top_level = Srgs::Rule.new("toplevel");
top_level_choices = Srgs::OneOf.new
item1 = Srgs::Item.new Srgs::RuleRef.new(weather)
item2 = Srgs::Item.new Srgs::RuleRef.new(sun)
top_level_choices << item1
top_level_choices << item2
top_level << top_level_choices

grammar << top_level << weather << sun << days << sunriseset

grammar.root = "toplevel"

puts Srgs.build(grammar)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
