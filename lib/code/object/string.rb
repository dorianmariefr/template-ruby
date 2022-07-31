class Code
  class Object
    class String < ::Code::Object
      attr_reader :raw

      def initialize(string)
        @raw = string
      end

      def evaluate(key, *args, **kargs)
        super
      end

      def succ
        ::Code::Object::String(raw.succ)
      end

      def to_s
        raw
      end

      def inspect
        raw.inspect
      end
    end
  end
end
