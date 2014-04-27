require 'capybara'

#
module Capybara
  module Bootstrap
    # A class meant to be subclassed by "model" objects that represent
    # Twitter Bootstrap UI elements
    class Base
      # @!attribute [r] css
      #   @return [String] the CSS selector provided on initialization
      # @!attribute [r] element
      #   @todo determine the approriate class to document this as returning
      #   @return [Object] the node object Capybara finder(s) returned
      attr_reader :css, :element
      # @!attribute [r] scope
      #   @return [String] the CSS selector that represents the scope of the
      #     element
      attr_writer :scope

      class << self
        # Finds all UI elements which are using the CSS selector for given
        # {Capybara::Bootstrap::Base} subclass
        def all(*)
          fail(
            NotImplementedError,
            "Attempted to call #all on `#{self}`"
          )
        end

        # Finds a single UI element which are using the CSS selector for given
        # {Capybara::Bootstrap::Base} subclass
        def find(*)
          fail(
            NotImplementedError,
            "Attempted to call #find on `#{self}`"
          )
        end

        # Wraps the provided scope to ensure that it is a valid Capybara node
        #
        # @todo check that `Capybara::Node` is the correct return (super)class
        # @return [Capybara::Node]
        def wrap(scope)
          if scope.respond_to?(:has_selector?)
            scope
          else
            Capybara.string(scope.to_s)
          end
        end
      end

      # @todo this method has no tests due to it's private nature
      # @return [void]
      def initialize(options)
        @css, @element, @scope = options.values_at(:css, :element, :scope)
      end

      # Define Base.new as private so only all/find can call it
      private_class_method :new

      # Delegates the click, hover, and text methods to the element attr_reader
      %i[click hover text].each do |action|
        define_method action do
          element.send(action)
        end
      end

      # @todo check that `Capybara::Node` is the correct return (super)class
      # @return [Capybara::Node] scope
      def scope
        self.class.wrap(@scope)
      end

      alias_method :to_css, :css

      # @return [String] the element attribute's text if available, the CSS
      #   selector otherwise
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
