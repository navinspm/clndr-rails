require_relative './spec_helper'

describe 'Clndr event' do
  before do
    @test = Clndr.new :test
  end

  shared_examples 'event' do
    it "should receive Date and Title" do
      @test.send(method_for_test,*args)
      expect(@test.events.length).to eq(1)
    end

    it "can receive other_data" do
      @test.send(method_for_test,*args,info:'info',msg:'msg',address:'adress')
      expect(@test.events.first.has_key?(:info)).to be_truthy
      expect(@test.events.first.has_key?(:msg)).to be_truthy
      expect(@test.events.first.has_key?(:address)).to be_truthy
    end


    it " should add event to events array" do
      @test.send(method_for_test,*args)
      @test.send(method_for_test,*args,some_info:'info')
      expect(@test.events.length).to eq(2)
    end

    it 'should raise exeption when recive wrong data format' do
      expect{@test.send(method_for_test,*wrong_args)}.to raise_error(Clndr::Error::WrongDateFormat)
    end
  end
  context 'add event'do
    it_should_behave_like 'event' do
      let(:method_for_test){:add_event}
      let(:args){[Time.now,'Title']}
      let(:wrong_args){['wrong date','Title']}
    end
  end

  context 'add multiday event'do
    it_should_behave_like 'event' do
      let(:method_for_test){:add_multiday_event}
      let(:args){[Time.now,Time.now,'Title']}
      let(:wrong_args){['wrong date','wrong date','Title']}
    end
  end

  context 'build events string' do
    it '.build_events should delete elements from events array' do
      @test.add_event(Time.now,'test1')
      @test.add_event(Time.now,'test2',some_info:'info')
      @test.send(:build_events)
      expect(@test.events.length).to eq(0)
    end

    it 'should contain multiDayEvents if calendar contain multiday event' do
      @test.add_multiday_event Time.now, Time.now, 'Title', spme_info:'info'
      expect(@test.view).to include('multiDayEvents:')
    end

  end

end