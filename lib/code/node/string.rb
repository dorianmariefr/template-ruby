class Code
  class Node
    class String < Node
      def initialize(parsed)
        @string = parsed
      end

      def evaluate(**args)
        ::Code::Object::String.new(@string)
      end
    end
  end
end
