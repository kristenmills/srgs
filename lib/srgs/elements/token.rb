module Srgs
  class Token

    attr_accessor :text, :display, :pron

    def initialize(text, display = nil, pron = nil)
      @text = text
      @display = display
      @pron = pron
    end

  end
end
