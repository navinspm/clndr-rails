class BaseController < ApplicationController
  def index
    @full = Clndr.new(:full)
    @full.add_event(Time.now, 'Это событие', location:"Пермь")
    @full.click_event[:nextMonth]='function(){alert("ffff")}'

    # @full = Clndr.new(:full)
    # @full.add_event Time.now, 'Test', location: 'NY'
    # @full.add_event Time.now+1.day,'Sec',location:"custom"
    # @default = Clndr.new(:blank)
    # @default.template = Clndr::Template::Blank
    # @default.weak_offset = true
    # @default.start_with_month= nil
    # @default.days_of_the_weak= nil
    # @default.click_event[:click] = 'function(){alert("ffff")}'
    # @default.target[:nextButton]='next'
    # @default.show_adjacent_months =false
    # Clndr.new(:custom_template).template = Clndr::Template.from_html('#custom-template')
  end
end
