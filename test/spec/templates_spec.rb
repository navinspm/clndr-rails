require_relative './spec_helper'

describe 'Clndr Templates' do
  it 'should have FULL template' do
    expect(Clndr::Template::FULL).to include('full')
  end

  it 'should have BLANK template' do
    expect(Clndr::Template::BLANK).to be_nil
  end

  it 'should have MINI template' do
    expect(Clndr::Template::MINI).to include('mini')
  end

  it 'should have SIMPLE template' do
    expect(Clndr::Template::SIMPLE).to include('simple')
  end

  it 'can get template from html' do
    expect(Clndr::Template.from_html('#some_id')).to eq( "$(\"#some_id\").html()".html_safe)
  end
end