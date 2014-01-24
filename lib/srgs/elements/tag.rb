  module Srgs
    class Tag

      attr_accessor :text, :xml_tag

      def initialize(text)
        @text = text
        @xml_tag = 'tag'
      end

    end
  end
