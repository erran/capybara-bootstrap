require 'capybara'

module Capybara
  module Bootstrap
    class Base
      attr_reader :element
      attr_reader :scope

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

        def validate_scope(scope)
          if scope.respond_to?(:has_selector?)
            scope
          else
            scope = Capybara.string(scope.to_s)
          end
        end
      end

      def initialize(options)
        @css, @element, @scope = options.values_at(:css, :element, :scope)
        @scope &&= validate_scope(@scope)
      end

      def scope
        validate_scope(@scope)
      end

      def to_css
        @css
      end

      def to_s
        if element && element.respond_to?(:text)
          element.text
        elsif respond_to?(:to_css)
          to_css
        else
          super
        end
      end

      def validate_scope(scope)
        if scope.respond_to?(:has_selector?)
          scope
        else
          scope = Capybara.string(scope.to_s)
        end
      end
    end
  end
end
