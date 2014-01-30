module Srgs
  class RuleRef

    attr_accessor :uri, :special

    def initialize(rule, special=nil)
      @uri = rule unless rule.nil? or rule.empty?
      @special =special
    end

  end
end
