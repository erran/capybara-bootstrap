require 'capybara/bootstrap/base'

module Capybara
  module Bootstrap
    class Navbar < Base
      UTILITY_CLASSES = %w[
        default collapse inverse
        righ left
        fixed_bottom fixed_top static_top
      ]

      attr_reader :utility_classes

      class << self
        def all(utility_classes, options)
          scope = validate_scope(options.delete(:scope))
          css = css_from_utility_classes(utility_classes)

          elements = scope.all(css, options)
          elements.map do |element|
            new(utility_classes, css: css, element: element, scope: scope)
          end
        end

        # @param [Hash] options
        # @option options :text
        def find(utility_classes, options)
          scope = validate_scope(options.delete(:scope))
          css = css_from_utility_classes(utility_classes)

          element = scope.find(css, options)
          new(utility_classes, css: css, element: element, scope: scope)
        end

        private

        def css_from_utility_classes(utility_classes)
          css = '.navbar'

          Array(utility_classes).each do |utility_class|
            utility_class = utility_class.to_s.gsub('_', '-')

            if UTILITY_CLASSES.include? utility_class
              css << ".navbar-#{utility_class}"
            else
              fail(
                ArgumentError,
                <<-ERROR
                got: first argument #{utility_classes}
                expected: #{utility_class} to be one of #{UTILITY_CLASSES}
                ERROR
              )
            end
          end

          css
        end
      end

      def initialize(utility_classes, options)
        options ||= {}
        options[:css] ||= utility_classes

        @css, @element, @scope = options.values_at(:css, :element, :scope)
        @scope &&= validate_scope(@scope)
        @utility_classes = utility_classes
      end
    end
  end
end
