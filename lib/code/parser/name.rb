class Code
  class Parser
    class Name < Language
      def space
        str(" ")
      end

      def newline
        str("\n")
      end

      def comma
        str(",")
      end

      def colon
        str(":")
      end

      def opening_curly_bracket
        str("{")
      end

      def closing_curly_bracket
        str("}")
      end

      def opening_parenthesis
        str("(")
      end

      def closing_parenthesis
        str(")")
      end

      def do_keyword
        str("do")
      end

      def end_keyword
        str("end")
      end

      def character
        colon.absent << comma.absent << space.absent << newline.absent << opening_curly_bracket.absent << closing_curly_bracket.absent << opening_parenthesis.absent << closing_parenthesis.absent << any
      end

      def root
        do_keyword.absent << end_keyword.absent << character.repeat(1)
      end
    end
  end
end