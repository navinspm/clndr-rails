class BaseController < ApplicationController
  def index
    @full = Clndr.new(:test)
    @full.add_event(Time.now, 'Это событие')
    @full.add_multiday_event(Time.now+1.day,Time.now+3.day,'Мулти',location: 'Russia')
    @full.start_with_month = Time.now
    @full.template= Clndr::Template::MINI
    @full.click_event[:click]="function(target) {
        if(target.events.length) {
          var daysContainer = $('##{@full.name}-clndr').find('.days-container');
          daysContainer.toggleClass('show-events', true);
          $('##{@full.name}-clndr').find('.x-button').click( function() {
            daysContainer.toggleClass('show-events', false);
          });}}"

    # @full.click_event[:onMonthChange]='function(){alert("ffff")}'

    # @full = Clndr.new(:full)
    # @full.add_event Time.now, 'Test', location: 'NY'
    # @full.add_event Time.now+1.day,'Sec',location:"custom"
    # @default = Clndr.new(:blank)
    # @default.template = Clndr::Template::BLANK
    # @default.week_offset = true
    # @default.start_with_month= nil
    # @default.days_of_the_week= nil
    # @default.click_event[:click] = 'function(){alert("ffff")}'
    # @default.target[:nextButton]='next'
    # @default.show_adjacent_months =false
    # Clndr.new(:custom_template).template = Clndr::Template.from_html('#custom-template')
  end
end
