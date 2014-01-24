require 'nokogiri'

module Srgs
  extend self

  def build(grammar)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.grammar do
        grammar.rules.each do |rule|
          rule(xml, rule)
        end
      end
    end
  end

  def example(example, xml)
    xml.example example.text
  end

  def item(item, xml)
    att = {}
    set(:repeat, att, item.repeat)
    set(:'repeat-prob', att, item.repeat_prob)
    set(:weight, att, item.weight)
    if item.element.is_a Token
      xml.item(att) do
        tag(item.tag, xml) unless item.tag.nil?
        token(item.element, xml)
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
  end

  def one_of(one_of, xml)

  end

  def rule(xml, rule)
    att = {id: rule.id}
    set(:scope, att, rule.scope)
    set(:'sapi:dynamic', att, rule.dynamic)
    xml.rule(att) do
      @rule.elements.each do |element|
        if element.is_a Item
          item(element, xml)
        end
      end
    end
  end

  def rule_ref(rule_ref, xml)

  end

  def tag(tag, xml)
    xml.tag tag.text
  end

  def token(token, xml)
    att = {}
    att(:'sapi:display', att, token.display)
    att(:'sapi:pron', att, token.pron)
    xml.token(att) token.text
  end

  def set(sym, att, value)
    att[sym] = value unless value.nil?
  end

end