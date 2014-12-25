require_relative './spec_helper'

describe 'Clndr Templates' do

  shared_examples 'templated' do
    it 'should contain' do
      expect(Clndr::Template.const_get(template)).to (pattern.nil? ? eq(nil) : include(pattern) )
    end
  end

  shared_examples 'template with css class' do
    it 'should contain css class' do
      @test = Clndr.new :test
      @test.template = Clndr::Template.const_get(template)
      expect(@test.view).to include("class=\"clearfix #{css_class}\"")
    end
  end

  context 'FULL template' do
    let(:template){:FULL}

    it_should_behave_like 'templated' do
        let(:pattern){'full'}
    end

    it_should_behave_like 'template with css class' do
      let(:css_class){'full-clndr-template'}
    end
  end

  context 'MINI template' do
    let(:template){:MINI}

    it_should_behave_like 'templated' do
      let(:pattern){'mini'}
    end

    it_should_behave_like 'template with css class' do
      let(:css_class){'mini-clndr-template'}
    end
  end

  context 'SIMPLE template' do
    let(:template){:SIMPLE}

    it_should_behave_like 'templated' do
      let(:pattern){'simple'}
    end

    it_should_behave_like 'template with css class' do
      let(:css_class){'simple-clndr-template'}
    end
  end

  context 'BLANK template' do
    let(:template){:BLANK}

    it_should_behave_like 'templated' do
      let(:pattern){nil}
    end

    it_should_behave_like 'template with css class' do
      let(:css_class){'blank-clndr-template'}
    end
  end

  it 'can get template from html' do
    expect(Clndr::Template.from_html('#some_id')).to eq( "$(\"#some_id\").html()".html_safe)
  end

end