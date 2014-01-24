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