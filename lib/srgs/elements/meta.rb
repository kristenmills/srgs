module Srgs
  class Meta

    attr_accessor :name, :http_equiv, :content, :xml_tag

    def initialize(content, name=nil, http_equiv=nil)
      @name = name
      @content = content
      @http_equiv = http_equiv
      @xml_tag = "meta"
    end
  end
end
