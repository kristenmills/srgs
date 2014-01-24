  module Srgs
    class Grammar

      attr_accessor :root, :rules, :xml_tag

      def initialize
        @root = ""
        @rules = Array.new
        @xml_tag = "grammar"
      end

    end
  end
