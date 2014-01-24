module Srgs
  class Grammar

    attr_accessor :text, :display, :pron, :xml_tag

    def initialize(text, display = nil, pron = nil)
      @root = text
      @display = display
      @pron = pron
      @xml_tag = 'token'
    end

  end
end
