require_relative './spec_helper'

describe 'Clndr configuration' do
  shared_examples 'configurable' do

    it 'should be configurable' do
      expect(@calendar.template).to eq(Clndr::Template::Simple)
    end

    it 'should get week_offset from config' do
      expect(@calendar.week_offset).to eq(0)
    end

    it 'should get start_with_month config' do
      expect(@calendar.start_with_month).to eq('2014-12-31')
    end

    it 'should get days_of_week config' do
      expect(@calendar.days_of_the_week.first).to eq('x')
    end

    it 'should get click_events config' do
      expect(@calendar.click_event[:click]).to include('js_function')
    end

    it 'should get targets config' do
      expect(@calendar.target[:nextButton]).to include('class')
    end

    it 'should get show_adjacent_months config' do
      expect(@calendar.show_adjacent_months).to be_falsey
    end

    it 'should get adjacent_days_change_month config' do
      expect(@calendar.adjacent_days_change_month).to be_truthy
    end

    it 'should get done_rendering config' do
      expect(@calendar.done_rendering).to include('callbaks_function')
    end

    it 'should get constraints_start config' do
      expect(@calendar.constraints_start).to eq('2014-12-31')
    end

    it 'should get constraints_end config' do
      expect(@calendar.constraints_end).to eq('2014-12-31')
    end

    it 'should get force_six_rows config' do
      expect(@calendar.force_six_rows).to be_falsey
    end
  end

  context 'init' do
    before :all do
      Clndr.configure do |config|
        config.template = Clndr::Template::Simple
        config.week_offset = false
        config.start_with_month = '2014-12-31'
        config.days_of_the_week =['x'] * 7
        config.click_events do |event|
          event[:click] ='some_js_function(){}'
        end
        config.targets do |target|
          target[:nextButton] = '.some_class'
        end
        config.show_adjacent_months = false
        config.adjacent_days_change_month = true
        config.done_rendering = 'some_callbaks_function(){}'
        config.constraints_start = '2014-12-31'
        config.constraints_end = '2014-12-31'
        config.force_six_rows = false
      end

      @calendar = Clndr.new(:test)
    end
    it_should_behave_like 'configurable'
  end

  context 'dinamycaly change config' do
    before :all do
      @calendar = Clndr.new(:test)
      @calendar.template = Clndr::Template::Simple
      @calendar.week_offset = false
      @calendar.start_with_month = '2014-12-31'
      @calendar.days_of_the_week =['x'] * 7
      @calendar.click_event[:click] ='some_js_function(){}'
      @calendar.target[:nextButton] = '.some_class'
      @calendar.show_adjacent_months = false
      @calendar.adjacent_days_change_month = true
      @calendar.done_rendering = 'some_callbaks_function(){}'
      @calendar.constraints_start = '2014-12-31'
      @calendar.constraints_end = '2014-12-31'
      @calendar.force_six_rows = false
    end
    it_should_behave_like 'configurable'
  end

  it 'should fall to default settings when #defaul_settings call' do
    Clndr.default_settings
    expect(Clndr.new(:test).template).to eq(Clndr::Template::Blank)
  end

  it 'should raise exception if date format wrong' do
    expect{Clndr.configure{|config| config.start_with_month = 'dsf'}}.to raise_error(Clndr::Error::WrongDateFormat)
    expect{Clndr.configure{|config| config.constraints_start = 'dsf'}}.to raise_error(Clndr::Error::WrongDateFormat)
    expect{Clndr.configure{|config| config.constraints_end = 'dsf'}}.to raise_error(Clndr::Error::WrongDateFormat)

  end

end