module Srgs
  @grammer = nil
  def example(text)
    @grammar.current_level << Example.new(text)
  end

  def grammar(root, &block)
    @grammar = Grammar.new 'root'
    instance_eval &block
    @grammar.current_level = nil
    puts build(@grammar)
  end

  def item(element = '', args = {}, &block)
    @grammar.current_level << Item.new(element, args)
    old_current = @grammar.current_level
    instance_eval &block
    @grammar.current_level = old_current
  end

  def lexicon(uri, type=nil)
    @grammar << Lexicon.new(uri, type)
  end

  def meta(content, name = nil, http_equiv = nil)
    @grammar << Meta.new(content, name, http_equiv)
  end

  def one_of(&block)
    old_current = @grammar.current_level
    @grammar.current_level = OneOf.new
    instance_eval &block
    @grammar.current_level = old_current
  end

  def public_rule(id, dynamic= nil,  &block)
    @grammar.current_level = Rule.new(id, 'public', dynamic)
    @grammar << @grammar.current_level
    instance_eval &block
    @grammar.current_level = nil
  end

  def private_rule(id, dynamic= nil,  &block)
    @grammar.current_level = Rule.new(id, 'private', dynamic)
    @grammar << @grammar.current_level
    instance_eval &block
    @grammar.current_level = nil
  end

  def reference(name, special=nil)
    @grammar.current_level << RuleRef.new(name, special)
  end

  def tag(text)
    @grammar.current_level << Tag.new(text)
  end

  def token(text, display=nil, pron = nils)
    @grammar.current_level << Token.new(text, display, pron)
  end
end