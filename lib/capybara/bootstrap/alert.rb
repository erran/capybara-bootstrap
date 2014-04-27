require 'capybara/bootstrap/base'

module Capybara
  module Bootstrap
    # A class that represents the .alert class
    class Alert < Base
      # @!attribute [r] type
      #   @return [Symbol] the type of alert (used to detect nested CSS)
      attr_reader :type

      class << self
        # Finds all .alert elements in the selected scope
        #
        # @return [Array<Capybara::Bootstrap::Alert>] an array of alerts
        def all(type, options)
          css = css_for_type(type)
          scope = wrap(options.delete(:scope))

          elements = scope.all(css, options)
          elements.map do |element|
            new(type, css: css, element: element, scope: scope)
          end
        end

        # Finds an alert inside of the given scope
        #
        # @param [Hash] options the options parameter passed to `scope#find()`
        # @option options [String] :scope the scope to search inside of
        def find(type, options)
          css = css_for_type(type)
          scope = wrap(options.delete(:scope))

          element = scope.find(css, options)
          new(type, css: css, element: element, scope: scope)
        end

        private

        # @param [Symbol] type the type for which to generate CSS
        # @raise [ArgumentError] if the type was not valid
        # @return [String] the CSS for a given type
        def css_for_type(type)
          case type
          when :any
            ".alert"
          when :success, :info, :warning, :danger
            ".alert.alert-#{type}"
          else
            fail(
              ArgumentError,
              'Expected one of :any, :success, :info, :warning, or :danger'
            )
          end
        end
      end

      # @param [Symbol] type the type of alert to create
      # @return [self] an alert with the provided options
      def initialize(type, options)
        options ||= {}
        options[:css] ||= type

        @css, @element, @scope = options.values_at(:css, :element, :scope)
        @type = type
      end
    end
  end
end
