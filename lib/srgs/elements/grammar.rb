module Srgs
  class Grammar

    attr_accessor :root, :lexicon, :rules, :metas, :current_level

    def initialize(root = '')
      @root = root
      @lexicon = nil
      @metas = Array.new
      @rules = Array.new
      @current_level = nil
    end

    def <<(element)
      @rules << element if element.is_a? Rule
      @lexicon = element if element.is_a? Lexicon
      @metas << element if element.is_a? Meta
      self
    end

  end
end
