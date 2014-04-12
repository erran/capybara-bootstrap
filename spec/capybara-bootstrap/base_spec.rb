describe Capybara::Bootstrap::Base, :type => :feature do
  describe '.all' do
    it 'should not be implemented' do
      expect {
        Capybara::Bootstrap::Base.all('div')
      }.to raise_error(NotImplementedError)
    end
  end

  describe '.find' do
    it 'should not be implemented' do
      expect {
        Capybara::Bootstrap::Base.find('div', :match => :first)
      }.to raise_error(NotImplementedError)
    end
  end

  describe '.new' do
    it 'should raise a NoMethodError' do
      expect {
        Capybara::Bootstrap::Base.new
      }.to raise_error(NoMethodError)
    end
  end

  describe '.wrap' do
    it 'should not wrap an object that responds to #has_selector?' do
      scope = double('scope')
      scope.stub(:has_selector?)

      wrapped_scope = Capybara::Bootstrap::Base.wrap(scope)
      expect(wrapped_scope).to be(scope)
    end

    it 'should wrap an object that does not respond to #has_selector?' do
      scope = double('scope')

      wrapped_scope = Capybara::Bootstrap::Base.wrap(scope)
      expect(wrapped_scope).to be_a(Capybara::Node::Simple)
      expect(wrapped_scope).not_to be(scope)
    end
  end

  # [todo] - test `#click`, `#hover`, and `#text`?

  describe '#scope' do
    it 'should return a wrapped scope' do
      scope = 'div'
      base = Capybara::Bootstrap::Base.allocate
      base.send(:initialize, scope: scope)

      expect(base.scope).to be_a(Capybara::Node::Simple)
      expect(base.scope).not_to be(scope)
    end
  end

  describe '#to_s' do
    let(:base) do
      base = Capybara::Bootstrap::Base.allocate
      base.send(:initialize, {})
      base
    end

    context 'with a valid element (which responds to #text)' do
      it 'should return the text of that element' do
        element = double('element')
        element.stub(:text).and_return('Lorem Ipsum')
        base.instance_variable_set(:@element, element)

        expect(base.to_s).to eq(element.text)
      end
    end

    context 'without a valid element (which responds to #text)' do
      it 'should return the #to_css' do
        css = 'h1#title'
        base.instance_variable_set(:@css, css)

        expect(base.to_s).to eq(css)
      end
    end

    context 'without css or a valid element (which responds to #text)' do
      it 'should return #inspect' do
        css = 'h1#title'
        base.instance_variable_set(:@css, css)

        expect(base.to_s).to eq(css)
      end
    end
  end
end
