module Srgs
  class Item

    attr_accessor :element, :repeat, :repeat_prob, :weight, :tag

    def initialize(element, tag=nil, repeat=nil, repeat_prob = nil, weight = nil)
      @element = element
      @tag = tag
      @repeat = repeat
      @repeat_prob = repeat_prob
      @weight = weight
    end

  end
end
