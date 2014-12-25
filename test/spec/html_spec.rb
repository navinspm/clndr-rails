require_relative './spec_helper'

describe 'Clndr generate html' do
  before do
    Clndr.default_settings
    @test = Clndr.new(:test)
  end

  it 'by .view method' do
    expect(@test.view).to include('id="test-clndr"')
  end

  it 'by .view method with html_options' do
    expect(@test.view(id:'some-test-id')).to include('some-test-id')
    expect(@test.view(id:'some-test-id', class:'some-test-class')).to include('some-test-class')
  end

  it 'by show_calendar method' do
    expect(show_calendar(:test)).to eq(@test.view)
  end

  it 'by show_calendar with html_options' do
    expect(show_calendar(:test,id:'some-test-id',class:'some-test-class')).to eq(@test.view(id:'some-test-id',class:'some-test-class'))
  end

  context 'with clndr option' do
    shared_examples 'valid generator' do

      it 'return nothing if parametr is default' do
        expect(@test.view).not_to include("#{parameter}:")
      end

      it 'return valid parametr' do
        @test.send(option,value)
        expect(@test.view).to include("#{parameter}:#{valid_value}")
      end

    end

    context 'template' do
      it_should_behave_like 'valid generator' do
        let(:option){ :template=}
        let(:value){Clndr::Template::SIMPLE}
        let(:valid_value){value}
        let(:parameter){'template'}
      end
    end

    context 'days_of_the_week' do
      it_should_behave_like 'valid generator' do
        let(:option){ :days_of_the_week=}
        let(:value){['x']*6}
        let(:valid_value){value}
        let(:parameter){'daysOfTheWeek'}
      end
    end

    context 'show_adjacent_months' do
      it_should_behave_like 'valid generator' do
        let(:option){ :show_adjacent_months=}
        let(:value){false}
        let(:valid_value){value}
        let(:parameter){'showAdjacentMonths'}
      end
    end

    context 'adjacent_days_change_month' do
      it_should_behave_like 'valid generator' do
        let(:option){ :adjacent_days_change_month=}
        let(:value){Time.now}
        let(:valid_value){value}
        let(:parameter){'adjacentDaysChangeMonth'}
      end
    end

    context 'done_rendering' do
      it_should_behave_like 'valid generator' do
        let(:option){ :done_rendering=}
        let(:value){'jsfunc(){}'}
        let(:valid_value){value}
        let(:parameter){'doneRendering'}
      end
    end

    context 'constraints_end' do
      it_should_behave_like 'valid generator' do
        let(:option){ :constraints_end=}
        let(:value){Time.now}
        let(:valid_value){" {endDate:'#{Time.now.strftime('%F')}'"}
        let(:parameter){'constraints'}
      end
    end

    context 'constraints_start' do
      it_should_behave_like 'valid generator' do
        let(:option){ :constraints_start=}
        let(:value){Time.now}
        let(:valid_value){" {startDate:'#{Time.now.strftime('%F')}'"}
        let(:parameter){'constraints'}
      end
    end

    context 'click_events' do
      it 'return nothing if parametr is default' do
        expect(@test.view).not_to include('clickEvent')
      end

      it 'return valid parametr' do
        @test.click_event[:click]='some_js(){}'
        expect(@test.view).to include('clickEvents: {click:some_js(){},}')
      end
    end

    context 'targets' do
      it 'return nothing if parametr is default' do
        expect(@test.view).not_to include('targets')
      end

      it 'return valid parametr' do
        @test.target[:nextButton]='.class'
        expect(@test.view).to include("targets: {nextButton:'.class'")
      end
    end

    context 'force_six_rows' do
      it 'return true if parametr is default' do
        expect(@test.view).to include('forceSixRows:true')
      end

      it 'return nothing if false' do
        @test.force_six_rows= false
        expect(@test.view).not_to include('forceSixRows:')
      end
    end

    context 'week_offset' do
      it 'return 1 if parametr is default' do
        expect(@test.view).to include('weekOffset:1')
      end

      it 'return nothing if 0' do
        @test.week_offset = false
        expect(@test.view).not_to include('weekOffset:0')
      end
    end

    context 'event' do
      it 'should havent events if events not add' do
      expect(@test.view).not_to include('events:')
      end
    end
  end

  context 'Link helpers' do
    before :all do
      Clndr.new :helpers
    end
    shared_examples 'navigate link' do
      it 'genearete link' do
        expect(self.send(link_type,:helpers,link_type.to_s)).to include("helpers.#{js}")
      end
      it 'generate link with some html_options' do
        expect(self.send(link_type,:helpers,link_type.to_s,style:'color:red;')).to include('style="color:red;"')
      end

      it 'generate link with available CLNDR callbacks' do
        expect(self.send(link_type,:helpers,link_type.to_s){true}).to include("withCallbacks: true")
      end
    end

    context 'next_month_link' do
      it_should_behave_like 'navigate link' do
        let(:link_type){:next_month_link}
        let(:js){'forward'}
      end
    end

    context 'previous_month_link' do
      it_should_behave_like 'navigate link' do
        let(:link_type){:previous_month_link}
        let(:js){'back'}
      end
    end

    context 'next_year_link' do
      it_should_behave_like 'navigate link' do
        let(:link_type){:next_year_link}
        let(:js){'nextYear'}
      end
    end

    context 'previous_year_link' do
      it_should_behave_like 'navigate link' do
        let(:link_type){:previous_year_link}
        let(:js){'previousYear'}
      end
    end
  end

end