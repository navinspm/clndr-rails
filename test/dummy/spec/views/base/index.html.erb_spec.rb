require 'rails_helper'

RSpec.describe 'base/index.html.erb', :js => true do
  it 'should show calendar' do
    visit root_path
    expect(page).to have_css('div.clndr')
  end

  it 'should have full calendar' do
      expect(page).to have_css('div.event-listing')
  end

  it 'should have blank calendar' do
      expect(page).to have_selector('table')
  end



end
