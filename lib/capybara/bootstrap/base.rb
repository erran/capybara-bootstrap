require 'capybara'

module Capybara
  module Bootstrap
    class Base
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
            scope = Capybara.string(scope.to_s)
          end
        end
      end

      def initialize(options)
        @css, @element, @scope = options.values_at(:css, :element, :scope)
        wrap(@scope)
      end

      # Define Base.new as private so only all/find can call it
      private_class_method :new

      %i[click hover text].each do |action|
        define_method action do
          element.send(action)
        end
      end

      def scope
        wrap(@scope)
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
    end
  end
end
