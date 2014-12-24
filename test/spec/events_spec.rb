require_relative './spec_helper'

describe 'Clndr event' do
  before do
    @test = Clndr.new :test
  end
  context 'add event'do

    it '.add_event should receive Date and Title' do
      @test.add_event(Time.now,'test')
      expect(@test.events.length).to eq(1)
    end

    it '.add_event can receive other_data' do
      @test.add_event(Time.now,'test',info:'info',msg:'msg',address:'adress')
      expect(@test.events.first.has_key?(:info)).to be_truthy
      expect(@test.events.first.has_key?(:msg)).to be_truthy
      expect(@test.events.first.has_key?(:address)).to be_truthy
    end


    it '.add_event should add event to events array' do
      @test.add_event(Time.now,'test')
      @test.add_event(Time.now,'test',some_info:'info')
      expect(@test.events.length).to eq(2)
    end

    it '.add_event should raise exeption when recive wrong data format' do
      expect{@test.add_event('dd','dd')}.to raise_error(Clndr::Error::WrongDateFormat)
    end
  end

  context 'build events string' do
    it '.build_events should delete elements from events array' do
      @test.add_event(Time.now,'test1')
      @test.add_event(Time.now,'test2',some_info:'info')
      @test.send(:build_events)
      expect(@test.events.length).to eq(0)
    end

  end

end