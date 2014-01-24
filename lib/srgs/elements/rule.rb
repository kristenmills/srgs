module Srgs
  class Rule

    attr_accessor :id, :scope, :dynamic, :elements

    def initialize(id, scope = 'private', dynamic = nil)
      @id = id
      @elements = Array.new
      @scope = scope
      @dynamic = dynamic
    end

    def <<(rule)
      @elements << element
    end

  end
end
