describe Capybara::Bootstrap::Alert, :type => :feature, :speed => :slow do
  describe '.all' do
    before(:each) do
      visit 'components/#alerts'
    end

    it 'should return 9 alerts when searching for any alerts' do
      alerts = Capybara::Bootstrap::Alert.all(:any, scope: page)
      expect(alerts.count).to eq(9)
    end

    it 'should return 2 alerts when searching for success alerts' do
      alerts = Capybara::Bootstrap::Alert.all(:success, scope: page)
      expect(alerts.count).to eq(2)
    end

    it 'should return 2 alerts when searching for info alerts' do
      alerts = Capybara::Bootstrap::Alert.all(:info, scope: page)
      expect(alerts.count).to eq(2)
    end

    it 'should return 3 alerts when searching for warning alerts' do
      alerts = Capybara::Bootstrap::Alert.all(:warning, scope: page)
      expect(alerts.count).to eq(3)
    end

    it 'should return 2 alerts when searching for danger alerts' do
      alerts = Capybara::Bootstrap::Alert.all(:danger, scope: page)
      expect(alerts.count).to eq(2)
    end
  end

  describe '.find' do
    it 'should accept regular Capybara matcher options' do
      visit 'components/#alerts'
      Capybara::Bootstrap::Alert.find(:any,
        scope: page,
        match: :first,
        text: 'Well done! You successfully read this important alert message.'
      )
    end

    it 'should raise an ArgumentError when an invalid type is specified' do
      message = 'Expected one of :any, :success, :info, :warning, or :danger'
      expect {
        Capybara::Bootstrap::Alert.find(:invalid_alert_type, scope: page)
      }.to raise_error(ArgumentError, message)
    end
  end
end
