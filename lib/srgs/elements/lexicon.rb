module Srgs
  class Lexicon

    attr_accessor :uri, :type

    def initialize(uri, type=nil)
      @uri = uri
      @type = type
    end

  end
end
