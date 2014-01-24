module Srgs
  class Lexicon

    attr_accessor :uri, :type, :xml_tag

    def initialize(uri, type=nil)
      @uri = uri
      @type = type
      @xml_tag = 'lexicon'
    end

  end
end