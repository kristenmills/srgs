module Srgs
  class Item

    attr_accessor :elements, :repeat, :repeat_prob, :weight

    def initialize(element = '', repeat=nil, repeat_prob = nil, weight = nil)
      @elements = [element]
      @tag = tag
      @repeat = repeat
      @repeat_prob = repeat_prob
      @weight = weight
    end

    def <<(element)
      @elements << element
      self
    end

  end
end
