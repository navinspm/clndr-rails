Clndr.configure do |config|
  config.template = Clndr::Template::FullCalendar
  config.weak_offset = false
  config.start_with_month = '2014-11-01'
  config.days_of_the_weak =["П","В", "С","ч","п","СБ","вс"]
  config.click_events do |event|
    event[:click] = 'function(target){}'
    event[:nextMonth]= 'function(mont){}'
    event[:previousMonth]= 'function(month){}'
    event[:onMonthChange]= 'function(month){}'
    event[:today]= 'function(month){}'
  end
  config.targets do |target|
    target[:nextButton]='clndr-next-button'
    target[:previousButton]= 'clndr-previous-button'
    target[:todayButton]= 'clndr-today-button'
    target[:day]= 'day'
    target[:empty]='empty'
  end
  config.show_adjacent_months= true
  config.adjacent_days_change_month= true
  config.done_rendering='function(){}' # or nil
  config.constraints_end= Time.now+1.month


end