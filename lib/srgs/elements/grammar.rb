module Srgs
  class Grammar

    attr_accessor :root, :lexicon, :rules

    def initialize(root = '')
      @root = root
      @lexicons = Array.new
      @rules = Array.new
    end

    def <<(rule)
      @rules << rule
    end

  end
end
