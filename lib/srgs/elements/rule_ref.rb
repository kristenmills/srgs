module Srgs
  class RuleRef

    attr_accessor :uri, :special

    def initialize(rule, special=nil)
      @uri = "##{rule.id}"
      @special =special
    end

  end
end
