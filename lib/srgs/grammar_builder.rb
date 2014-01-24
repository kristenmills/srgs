require 'nokogiri'

module Srgs
  extend self

  def build(grammar)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.grammar do
        lexicon(grammar.lexicon, xml) unless grammar.lexicon.nil?
        grammar.metas.each do |meta|
          meta(meta, xml)
        end
        grammar.rules.each do |rule|
          rule(rule, xml)
        end
      end
    end.to_xml
  end

  def example(example, xml)
    xml.example example.text
  end

  def item(item, xml)
    att = {}
    set(:repeat, att, item.repeat)
    set(:'repeat-prob', att, item.repeat_prob)
    set(:weight, att, item.weight)
    if item.element.is_a? Token
      xml.item(att) do
        tag(item.tag, xml) unless item.tag.nil?
        token(item.element, xml)
      end
    elsif item.element.is_a? RuleRef
      xml.item(att) do
        tag(item.tag, xml) unless item.tag.nil?
        rule_ref(item.element, xml)
      end
    else
      xml.item(item.element, att) do
        tag(item.tag, xml) unless item.tag.nil?
      end
    end
  end

  def lexicon(lexicon, xml)
    att = {uri: lexicon.uri }
    set(:type, att, lexicon.type)
    xml.lexicon(att)
  end

  def meta(meta, xml)
    att = { content: meta.content }
    set(:'http-equiv', att, meta.http_equiv)
    set(:name, att, meta.name)
    xml.meta(att)
  end

  def metadata(metadata, xml)
    #TODO
    raise "Not yet implemented"
  end

  def one_of(one_of, xml)
    xml.send('one-of') do
      one_of.items.each do |item|
        item(item, xml)
      end
    end
  end

  def rule(rule, xml)
    att = {id: rule.id}
    set(:scope, att, rule.scope)
    set(:'sapi:dynamic', att, rule.dynamic)
    xml.rule(att) do
      rule.elements.each do |element|
        if element.is_a? Item
          item(element, xml)
        elsif element.is_a? RuleRef
          rule_ref(element, xml)
        elsif element.is_a? OneOf
          one_of(element, xml)
        elsif element.is_a? Token
          token(element, xml)
        elsif element.is_a? Tag
          tag(element, xml)
        end
      end
    end
  end

  def rule_ref(rule_ref, xml)
    att = { uri: rule_ref.uri }
    set(:special, att, rule_ref.special)
    xml.ruleref(att)
  end

  def tag(tag, xml)
    xml.tag tag.text
  end

  def token(token, xml)
    att = {}
    set(:'sapi:display', att, token.display)
    set(:'sapi:pron', att, token.pron)
    xml.token(token.text, att)
  end

  def set(sym, att, value)
    att[sym] = value unless value.nil?
  end

end