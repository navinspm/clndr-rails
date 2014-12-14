require 'rails_helper'

RSpec.describe "base/index.html.erb", :js => true do
  it "should show calendar" do
    visit root_path
    page.save_screenshot('screenshot.png')
    expect(page).to have_css('div.clndr')
  end
end
