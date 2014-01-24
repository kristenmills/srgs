module Srgs
  class Item

    attr_accessor :text, :repeat, :repeat_prob, :weight, :xml_tag

    def initialize(text, repeat=nil, repeat_prob = nil, weight = nil)
      @text = text
      @repeat = repeat
      @repeat_prob = repeat_prob
      @weight = weight
      @xml_tag = 'item'
    end

  end
end
