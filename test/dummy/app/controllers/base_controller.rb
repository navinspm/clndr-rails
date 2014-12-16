class BaseController < ApplicationController
  def index
    Clndr.new(:full).adjacent_days_change_month = true
    @default = Clndr.new(:blank)
    @default.template = Clndr::Template::Blank
    @default.weak_offset = true
    @default.start_with_month= nil
    @default.days_of_the_weak= nil
    @default.click_event[:click] = 'function(){alert("ffff")}'
    @default.target[:nextButton]='next'
    @default.show_adjacent_months =false
    Clndr.new(:custom_template).template = Clndr::Template.from_html('#custom-template')
  end
end
