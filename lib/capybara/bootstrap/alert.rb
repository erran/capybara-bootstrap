require 'capybara/bootstrap/base'

module Capybara
  module Bootstrap
    class Alert < Base
      attr_reader :type

      class << self
        def all(type, options)
          css = css_for_type(type)
          scope = wrap(options.delete(:scope))

          elements = scope.all(css, options)
          elements.map do |element|
            new(type, css: css, element: element, scope: scope)
          end
        end

        # @param [Hash] options
        # @option options :text
        def find(type, options)
          css = css_for_type(type)
          scope = wrap(options.delete(:scope))

          element = scope.find(css, options)
          new(type, css: css, element: element, scope: scope)
        end

        private

        def css_for_type(type)
          case type
          when :success, :info, :warning, :danger
            ".alert.alert-#{type}"
          else
            fail(
              ArgumentError,
              'Expected one of :success, :info, :warning, or :danger'
            )
          end
        end
      end

      def initialize(type, options)
        options ||= {}
        options[:css] ||= type

        @css, @element, @scope = options.values_at(:css, :element, :scope)
        @type = type
      end
    end
  end
end
