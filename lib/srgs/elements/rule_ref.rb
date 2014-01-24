module Srgs
  class RuleRef

    attr_accessor :uri, :xml_tag

    def initialize(rule)
      @uri = "##{rule.id}"
      @xml_tag = 'ruleref'
    end

  end
end
