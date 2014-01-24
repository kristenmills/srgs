module Srgs
  class OneOf

    attr_accessor :items

    def initialize
      @items = Array.new
    end

    def <<(rule)
      @items << items
    end

  end
end
