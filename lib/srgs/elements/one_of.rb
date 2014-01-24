module Srgs
  class OneOf

    attr_accessor :items

    def initialize
      @items = Array.new
    end

    def <<(item)
      @items << item
      self
    end

  end
end
