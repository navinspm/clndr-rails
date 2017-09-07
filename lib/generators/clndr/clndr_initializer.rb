Clndr.configure do |config|

  # you can configure default template, jast use Clndr::Template::<template_name or from_html(selector)>
  config.template = Clndr::Template::FULL

  # start the week off on Sunday (true), Monday (false)
  # If you are changing the value ensure you are changing the abbreviation below 
  config.week_offset = true

  # An array of day abbreviation labels for the days
  config.days_of_the_week =['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']

  # determines which month to start with using either a date string in format `YYYY-MM-DD`, instance of `Time` class or `nil` (if use nil Clndr will use current month)
  config.start_with_month = Time.now

  # Configure callbacks. Get argument string of js function
  config.click_events do |event|

    # returns a 'target' object containing the DOM element, any events, and the date as a moment.js object.
    event[:click] = 'function(target){}'

    # fired when a user goes forward a month. returns a moment.js object set to the correct month.
    event[:nextMonth]= 'function(mont){}'

    # fired when a user goes back a month. returns a moment.js object set to the correct month.
    event[:previousMonth]= 'function(month){}'

    # fired when a user goes back OR forward a month. returns a moment.js object set to the correct month.
    event[:onMonthChange]= 'function(month){}'

    # fired when a user goes to the current month/year. returns a moment.js object set to the correct month.
    event[:today]= 'function(month){}'
    
  end

  # the target classnames that CLNDR will look for to bind events. these are the defaults.
  config.targets do |target|
    target[:nextButton]='clndr-next-button'
    target[:previousButton]= 'clndr-previous-button'
    target[:todayButton]= 'clndr-today-button'
    target[:day]= 'day'
    target[:empty]='empty'
  end

  # show the numbers of days in months adjacent to the current month (and populate them with their events)
  config.show_adjacent_months= true

  # when days from adjacent months are clicked, switch the current month.
  # fires nextMonth/previousMonth/onMonthChange click callbacks
  config.adjacent_days_change_month= true

  # a callback when the calendar is done rendering. This is a good place to bind custom event handlers.
  config.done_rendering='function(){}' # or nil

  # Set range of dates for calendar
  # By default dont used

  #config.constraints_start= Time.now
  #config.constraints_end= Time.now

  # fixed count of calendar rows
  config.force_six_rows = false

  # setup custom css classes for some calendar elements like day, event etc.
  # by default empty and use default CLNDR css classes
  config.classes do |custom_class|
    custom_class[:today] = "my-today"
    custom_class[:event] = "my-event"
    custom_class[:past]= "my-past"
    custom_class[:lastMonth] = "my-last-month"
    custom_class[:nextMonth] = "my-next-month"
    custom_class[:adjacentMonth] = "my-adjacent-month"
    custom_class[:inactive] = "my-inactive"
  end
end