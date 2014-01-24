module Srgs
  class Metadata

    attr_accessor :text, :xml_tag

    def initialize(text)
      @text = text
      @xml_tag = 'metadata'
    end

  end
end
