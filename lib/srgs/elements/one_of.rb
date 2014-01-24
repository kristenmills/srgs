module Srgs
  class OneOf

    attr_accessor :items, :xml_tag

    def initialize
      @items = Array.new
      @xml_tag = 'one-of'
    end

    def <<(rule)
      @items << items
    end

  end
end
