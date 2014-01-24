module Srgs
  class Grammar

    attr_accessor :root, :lexicon, :rules

    def initialize(root = '')
      @root = root
      @lexicon = nil
      @metas = Array.new
      @rules = Array.new
    end

    def <<(element)
      @rules << element if element.is_a Rule
      @lexicon = element if element is_a Lexicon
      @metas << element if element is_a Meta
    end

  end
end
