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

    def <<(element)
      @tag = element if element.is_a? Tag
      @element = element if(element.is_a? Token or element.is_a? String)
      self
    end

  end
end
