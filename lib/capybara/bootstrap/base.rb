require 'capybara'

module Capybara
  module Bootstrap
    class Base
      attr_reader :css
      attr_reader :element
      attr_writer :scope

      class << self
        def all(*)
          fail(
            NotImplementedError,
            "Attempted to call #all on `#{self}`"
          )
        end

        def find(*)
          fail(
            NotImplementedError,
            "Attempted to call #find on `#{self}`"
          )
        end

        def wrap(scope)
          if scope.respond_to?(:has_selector?)
            scope
          else
            Capybara.string(scope.to_s)
          end
        end
      end

      # TODO: This method has no tests
      def initialize(options)
        @css, @element, @scope = options.values_at(:css, :element, :scope)
      end

      # Define Base.new as private so only all/find can call it
      private_class_method :new

      %i[click hover text].each do |action|
        define_method action do
          element.send(action)
        end
      end

      def scope
        self.class.wrap(@scope)
      end

      alias_method :to_css, :css

      def to_s
        if element && element.respond_to?(:text)
          element.text
        elsif css && respond_to?(:to_css)
          to_css
        else
          super
        end
      end
    end
  end
end
