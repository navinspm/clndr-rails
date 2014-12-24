require_relative './spec_helper'

describe 'Clndr Templates' do
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