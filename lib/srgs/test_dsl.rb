require 'srgs'

module Thing
  include Srgs

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
        reference 'weather'
        reference 'days'
      end
    end
  end
end