module Srgs
  class Grammar

    attr_accessor :root, :lexicon, :rules

    def initialize(root = '')
      @root = root
      @lexicons = Array.new
      @metas = Array.new
      @rules = Array.new
    end

    def <<(element)
      @rules << element if element.is_a Rule
      @lexicons << element if element is_a Lexicon
      @metas << element if element is_a Meta
    end

  end
end
