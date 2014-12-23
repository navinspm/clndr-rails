require_relative './spec_helper'
describe Clndr do
  context 'Templates' do
    it 'should have Full template' do
      expect(Clndr::Template::Full).to include('full')
    end

    it 'should have Blank template' do
      expect(Clndr::Template::Blank).to be_nil
    end

    it 'should have Mini template' do
      expect(Clndr::Template::Mini).to include('mini')
    end

    it 'should have Simple template' do
      expect(Clndr::Template::Simple).to include('simple')
    end

    it 'can get template from html' do
      expect(Clndr::Template.from_html('#some_id')).to eq( "$(\"#some_id\").html()".html_safe)
    end
  end

  context 'create and find calendar method' do
    before :all do
      Clndr.new(:test1)
      Clndr.new(:test2)
    end

    it '#new should add calendar to calendar bean' do
      expect(Clndr.calendar_basket[:test1]).to be_instance_of Clndr
      expect(Clndr.calendar_basket[:test2]).to be_instance_of Clndr
      expect(Clndr.calendar_basket[:test3]).to be_nil
    end

    it '#get_calendar should return calendar' do
      expect(Clndr.get_calendar(:test1)).to be_instance_of Clndr
    end

    it '#get_calendar should raise exeption if calendar not found' do
      expect{Clndr.get_calendar(:undefined)}.to raise_error(Clndr::Error::CalendarNotFound)
    end

    it '#new should create calendar with string name' do
      Clndr.new('test calendar')
      expect(Clndr.get_calendar('test calendar')).to be_instance_of Clndr
    end
  end

  context 'configuration' do
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
  end
end