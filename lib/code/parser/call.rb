class Code
  class Parser
    class Call < Parslet::Parser
      rule(:dictionnary) { ::Code::Parser::Dictionnary.new }
      rule(:code) { ::Code::Parser::Code.new.present }
      rule(:name) { ::Code::Parser::Name.new }
      rule(:function_arguments) { ::Code::Parser::Function.new.arguments }

      rule(:dot) { str(".") }
      rule(:opening_parenthesis) { str("(") }
      rule(:closing_parenthesis) { str(")") }
      rule(:opening_curly_bracket) { str("{") }
      rule(:closing_curly_bracket) { str("}") }
      rule(:comma) { str(",") }
      rule(:colon) { str(":") }
      rule(:ampersand) { str("&") }
      rule(:asterisk) { str("*") }
      rule(:pipe) { str("|") }
      rule(:do_keyword) { str("do") }
      rule(:end_keyword) { str("end") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:whitespace) { (space | newline).repeat(1) }
      rule(:whitespace?) { whitespace.maybe }

      rule(:keyword_argument) do
        name >> whitespace? >> colon >> whitespace? >> code.as(:value)
      end

      rule(:regular_argument) do
        ampersand.as(:block).maybe >>
          (asterisk >> asterisk).as(:keyword_splat).maybe >>
          asterisk.as(:splat).maybe >> code.as(:value)
      end

      rule(:argument) do
        keyword_argument.as(:keyword) | regular_argument.as(:regular)
      end

      rule(:arguments) do
        argument.repeat(1, 1) >>
          (whitespace? >> comma >> whitespace? >> argument).repeat
      end

      rule(:single_call) do
        dictionnary.as(:left) >>
          (
            opening_parenthesis >> whitespace? >>
              arguments.as(:arguments).maybe >> whitespace? >>
              closing_parenthesis
          ) >> block.as(:block).maybe
      end

      rule(:chained_single_call) do
        dot >> name >>
          (
            opening_parenthesis >> whitespace? >>
              arguments.as(:arguments).maybe >> whitespace? >>
              closing_parenthesis
          ).maybe >> block.as(:block).maybe
      end

      rule(:chained_call) do
        dictionnary.as(:left) >> chained_single_call.repeat(1).as(:right)
      end

      rule(:block_arguments) do
        pipe >> whitespace? >> function_arguments >> whitespace? >> pipe
      end

      rule(:block) do
        (
          whitespace >> do_keyword >> whitespace >>
            block_arguments.as(:arguments).maybe >> code.as(:body).maybe >>
            end_keyword
        ) |
          (
            whitespace? >> opening_curly_bracket >> whitespace >>
              block_arguments.as(:arguments).maybe >> code.as(:body).maybe >>
              closing_curly_bracket
          )
      end

      rule(:call) { (single_call | chained_call).as(:call) | dictionnary }

      root(:call)
    end
  end
end
