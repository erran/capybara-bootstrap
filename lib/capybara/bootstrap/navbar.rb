require 'capybara/bootstrap/base'

module Capybara
  module Bootstrap
    # A class that provides finder methods for Twitter Bootstrap .navbar
    # elements
    class Navbar < Base
      # Utility classes that are defined for .navbar objects
      UTILITY_CLASSES = %w[
        default collapse inverse
        fixed-bottom fixed-top static-top
        right left
      ]

      # @!attribute [r] utility_classes
      #   @return [Array<String>] a list of utility classes default to Bootstrap
      attr_reader :utility_classes

      class << self
        # Finds all UI elements which are using the .navbar CSS selector
        # @param [Array<String>,String] utility_classes one or more CSS
        #   class selectors
        # @param [Hash] options the options hash to use
        # @return [Array<Capybara::Bootstrap::Navbar>] all the navbars present
        #   in the scope
        def all(utility_classes, options)
          css = css_from_utility_classes(utility_classes)
          scope = wrap(options.delete(:scope))

          elements = scope.all(css, options)
          elements.map do |element|
            new(utility_classes, css: css, element: element, scope: scope)
          end
        end

        # Finds a single UI element which is using the .navbar CSS selector
        # @param [Array<String>,String] utility_classes one or more CSS
        #   class selectors
        # @param [Hash] options the options hash to use
        # @return [Array<Capybara::Bootstrap::Navbar>] the navbar that matches
        #   all provided options
        def find(utility_classes, options)
          css = css_from_utility_classes(utility_classes)
          scope = wrap(options.delete(:scope))

          element = scope.find(css, options)
          new(utility_classes, css: css, element: element, scope: scope)
        end

        private

        # Generates CSS for the given utility class
        #
        # @param [Array<String>,String] utility_classes one or more CSS
        #   class selectors
        # @raise [ArgumentError] if utility_classes are invalid
        # @return [String] the CSS selector for the navbar and navbar utility
        #   classes
        def css_from_utility_classes(utility_classes)
          css = '.navbar'

          Array(utility_classes).each do |utility_class|
            if UTILITY_CLASSES.include? utility_class
              css << ".navbar-#{utility_class}"
            else
              fail(
                ArgumentError,
                <<-ERROR
                got: #{utility_classes}
                expected: #{utility_class} to be one of #{UTILITY_CLASSES}
                ERROR
              )
            end
          end

          css
        end
      end

      # @param [Array<String>,String] utility_classes one or more CSS
      #   class selectors
      # @param [Hash] options the options hash to use
      def initialize(utility_classes, options)
        options ||= {}
        options[:css] ||= utility_classes

        @css, @element, @scope = options.values_at(:css, :element, :scope)
        @utility_classes = utility_classes
      end
    end
  end
end
