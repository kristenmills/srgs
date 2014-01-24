  module Srgs
    class Rule

      attr_accessor :id, :scope, :dynamic, :elements, :xml_tag

      def initialize(id, scope = 'private', dynamic = false)
        @id = id
        @elements = Array.new
        @xml_tag = 'rule'
      end

      def <<(rule)
        @elements << element
      end

    end
  end
