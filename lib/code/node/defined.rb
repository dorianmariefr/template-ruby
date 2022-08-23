class Code
  class Node
    class Defined < Node
      def initialize(defined)
        @name = defined.fetch(:name)
      end

      def evaluate(**args)
        ::Code::Object::Boolean.new(args.fetch(:context).key?(name))
      end

      private

      def name
        ::Code::Object::String.new(@name.to_s)
      end
    end
  end
end
