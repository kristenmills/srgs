require 'nokogiri'

module Srgs
  extend self

  def build(grammar)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.grammar(:'xml:lang' => "en-US",
                  root: grammar.root,
                  xmlns:"http://www.w3.org/2001/06/grammar",
                  version: "1.0",
                  :'tag-format' => "semantics/1.0") do
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
    xml.item(att) do
      item.elements.each do |element|
        case element
        when Token
          token(element, xml)
        when RuleRef
          rule_ref(element, xml)
        when Tag
          tag(element, xml)
        when String
          text(element, xml)
        else
          raise "Can't add #{element.class} to item."
        end
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
        case element
        when Item
          item(element, xml)
        when RuleRef
          rule_ref(element, xml)
        when OneOf
          one_of(element, xml)
        when Token
          token(element, xml)
        when Tag
          tag(element, xml)
        when Example
          example(element, xml)
        else
          raise "Can't add #{element.class} to item"
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

  def text(text, xml)
    xml.text text
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
