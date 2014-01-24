module Srgs
  class RuleRef

    attr_accessor :uri

    def initialize(rule)
      @uri = "##{rule.id}"
    end

  end
end
