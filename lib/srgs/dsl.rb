module Srgs
  module DSL
    @grammer = nil
    def example(text)
      @grammar.current_level << Example.new(text)
    end

    def grammar(root, &block)
      @grammar = Grammar.new root
      instance_eval &block
      @grammar.current_level = nil
      grammar =  Srgs.build(@grammar)
      puts grammar
      grammar
    end

    def item(element = '', args = {}, &block)
      item = Item.new(element, args[:repeat], args[:repeat_prob], args[:weight])
      @grammar.current_level << item
      old_current = @grammar.current_level
      @grammar.current_level = item
      instance_eval &block unless block.nil?
      @grammar.current_level = old_current
    end

    def lexicon(uri, args = {})
      @grammar << Lexicon.new(uri, args[:type])
    end

    def meta(content, args = {})
      @grammar << Meta.new(content, args[:name], args[:http_equiv])
    end

    def one_of(&block)
      old_current = @grammar.current_level
      @grammar.current_level = OneOf.new
      old_current << @grammar.current_level
      instance_eval &block
      @grammar.current_level = old_current
    end

    def public_rule(id, args = {}, &block)
      @grammar.current_level = Rule.new(id, 'public', args[:dynamic])
      @grammar << @grammar.current_level
      instance_eval &block
      @grammar.current_level = nil
    end

    def private_rule(id, args = {},  &block)
      @grammar.current_level = Rule.new(id, 'private', args[:dynamic])
      @grammar << @grammar.current_level
      instance_eval &block
      @grammar.current_level = nil
    end

    def reference(name, args = {})
      @grammar.current_level << RuleRef.new(name, args[:special])
    end

    def reference_item(name, args = {})
      @grammar.current_level << Item.new(RuleRef.new(name, args[:special]))
    end

    def tag(text)
      @grammar.current_level << Tag.new(text)
    end

    def text(text)
      @grammar.current_level << text
    end

    def token(text, args = {})
      @grammar.current_level << Token.new(text, args[:display], args[:pron])
    end
  end
end