module Super
  module S1
    class A
      def foo(a)
        a << "A#foo"
        bar(a)
      end
      def bar(a)
        a << "A#bar"
      end
    end
    class B < A    
      def foo(a)
        a << "B#foo"
        super(a)
      end
      def bar(a)
        a << "B#bar"
        super(a)
      end
    end
  end

  module S2
    class A
      def baz(a)
        a << "A#baz"
      end
    end
    class B < A
      def foo(a)
        a << "B#foo"
        baz(a)
      end
    end
    class C < B
      def baz(a)
        a << "C#baz"
        super(a)
      end
    end
  end

  module S3
    class A
      def foo(a)
        a << "A#foo"
      end
      def self.foo(a)
        a << "A::foo"
      end
      def self.bar(a)
        a << "A::bar"
        foo(a)
      end
    end
    class B < A
      def self.foo(a)
        a << "B::foo"
        super(a)
      end
      def self.bar(a)
        a << "B::bar"
        super(a)
      end
    end
  end
  
  module S4
    class A
      def foo(a)
        a << "A#foo"
      end
    end
    class B < A
      def foo(a, b)
        a << "B#foo(a,#{b})"
        super(a)
      end
    end
  end

  class S5
    def here
      :good
    end
  end

  class S6 < S5
    def under
      yield
    end

    def here
      under {
        super
      }
    end
  end

  class S7 < S5
    define_method(:here) { super() }
  end

  module MS1
    module ModA
      def foo(a)
        a << "ModA#foo"
        bar(a)
      end      
      def bar(a)
        a << "ModA#bar"
      end
    end
    class A
      include ModA
    end
    module ModB
      def bar(a)
        a << "ModB#bar"
        super(a)
      end
    end
    class B < A    
      def foo(a)
        a << "B#foo"
        super(a)
      end
      include ModB
    end
  end
  
  module MS2
    class A
      def baz(a)
        a << "A#baz"
      end
    end
    module ModB
      def foo(a)
        a << "ModB#foo"
        baz(a)
      end
    end
    class B < A
      include ModB
    end
    class C < B
      def baz(a)
        a << "C#baz"
        super(a)
      end
    end
  end
  
  module MS3
    module ModA
      def foo(a)
        a << "ModA#foo"
      end
      def bar(a)
        a << "ModA#bar"
        foo(a)
      end
    end
    class A
      def foo(a)
        a << "A#foo"
      end
      class << self
        include ModA
      end
    end
    class B < A
      def self.foo(a)
        a << "B::foo"
        super(a)
      end
      def self.bar(a)
        a << "B::bar"
        super(a)
      end
    end
  end  

  module MS4
    module Layer1
      def example
        5
      end
    end

    module Layer2
      include Layer1
      def example
        super
      end
    end

    class A
      include Layer2
      public :example
    end
  end

  class MM_A
    undef_method :is_a?
  end

  class MM_B < MM_A
    def is_a?(blah)
      # should fire the method_missing below
      super
    end

    def method_missing(*)
      false
    end
  end
end
