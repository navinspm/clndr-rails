require_relative './spec_helper'

describe Clndr do
   describe 'Create and find calendar method' do
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

    it '#get_calendar should raise exception if calendar not found' do
      expect{Clndr.get_calendar(:undefined)}.to raise_error(Clndr::Error::CalendarNotFound)
    end

    it '#new should create calendar with string name' do
      Clndr.new('test calendar')
      expect(Clndr.get_calendar('test calendar')).to be_instance_of Clndr
    end
  end
end