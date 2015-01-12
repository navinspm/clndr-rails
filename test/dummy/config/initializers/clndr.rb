Clndr.configure do |config|
  config.classes do |custom_class|
   custom_class[:today]= 'my-today'
  end
  # config.template = Clndr::Template::FULL
  # config.week_offset = false
  # config.start_with_month = '2014-11-01'
  # config.days_of_the_week =["П","В", "С","ч","п","СБ","вс"]
  # config.click_events do |event|
  #   event[:click] = 'function(target){}'
  #   event[:nextMonth]= 'function(mont){}'
  #   event[:previousMonth]= 'function(month){}'
  #   event[:onMonthChange]= 'function(month){}'
  #   event[:today]= 'function(month){}'
  # end
  # config.targets do |target|
  #   target[:nextButton]='clndr-next-button'
  #   target[:previousButton]= 'clndr-previous-button'
  #   target[:todayButton]= 'clndr-today-button'
  #   target[:day]= 'day'
  #   target[:empty]='empty'
  # end
  # config.show_adjacent_months= true
  # config.adjacent_days_change_month= true
  # config.done_rendering='function(){}' # or nil
  # config.constraints_start= Time.now
  # config.constraints_end= Time.now
end