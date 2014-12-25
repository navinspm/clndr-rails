[![Build Status](https://travis-ci.org/sedx/clndr-rails.svg?branch=master)](https://travis-ci.org/sedx/clndr-rails) [![Code Climate](https://codeclimate.com/github/sedx/clndr-rails/badges/gpa.svg)](https://codeclimate.com/github/sedx/clndr-rails)
#Clndr Rails
Simple way to insert calendar view into your rails app
This gem based on [CLNDR.js](http://kylestetz.github.io/CLNDR/)

##Instalation
For basic usage just include clndr-rails gem in `Gemfile`:

```
gem 'clndr-rails'
```
then run

```
bundle install
```

##Usage
Include clndr-rails javascripts and dependency libraries in your `app/assets/javascripts/application.js`:

```
//= require jquery
//= require moment
//=require underscore
//=require clndr-rails
```
and include css if you want use built in templates. Add into `app/assets/stylesheets/application.css`:

```
*= require clndr-rails
```

###Create and use calendar
Create calendar is very simple.
Just use `Clndr.new(:name_of_clndr)` in your controller or other else.
You can access to  Clndr by `:name_of_clndr` in helpers
If you need dynamically change some settings you can assignment your Clndr to instance variable and use config methods, eg:
```
@simple_clndr = Clndr.new(:simple)
@simple_clndr.start_with_month = Time.now-1.yaer
```
To add event just use `.add_event(date,name,*other_data)` method.
```
@simple_clndr.add_event(Time.now,'Event title',description:'You can access to description in your template by <%%= event.location %>.'
```
Also you can add multiday event:
```
# add_multiday_event(start_date,end_date,name,*other_data)
@simple_clndr.add_multiday_event('2012-12-1','2012-12-31','December 2012')
```
If you need use public CLNDR API you can use js var that same your Clnd name (see the generated code).

[More about API](https://github.com/kylestetz/CLNDR#returning-the-instance--public-api)

###Helpers
For display Clndr in your view you can use `show_calendar(:clndr_name,html_atributs)` helper
```
<%= show_calendar(:simple, id:'simple-calendar',style:'width:60%';)%>
```
or `.view` method:
```
<%= @simple_calendar.view %>
```

If you plane use Public API you can use link helpers:
```
next_month_link(calendar_name, text, html_options)
previous_month_link(calendar_name, text, html_options)
next_year_link(calendar_name, text, html_options)
previous_year_link(calendar_name, text, html_options)
```
In each link helper you can pass empty block or block with true to activate events callback.

###Templates
CLNDR.js doesn't generate HTML,it inject data to yours template.
If you want quick start you can use built in gem templates.
All templates include in `Clndr::Template` module
Now add two templates `FULL`, `MINI` and `SIMPLE`, also you can use `BLANK` template (it's empty template and CLNDR.js generate simple html)
If you need more functionality or want create custom design you must use `Clndr::Template.from_html()` method.
This metod get one argument selector in JQuery's format (`'#some-id'` or `'.some-class'`)
This is example of simple template:

```
<script type="text/template" id="full-clndr-template">
  <div class="clndr-controls">
    <div class="clndr-previous-button">&lt;</div>
    <div class="clndr-next-button">&gt;</div>
    <div class="current-month"><%= month %> <%= year %></div>
  </div>
  <div class="clndr-grid">
    <div class="days-of-the-week clearfix">
      <% _.each(daysOfTheWeek, function(day) { %>
        <div class="header-day"><%= day %></div>
      <% }); %>
    </div>
    <div class="days">
      <% _.each(days, function(day) { %>
        <div class="<%= day.classes %>" id="<%= day.id %>"><span class="day-number"><%= day.day %></span></div>
      <% }); %>
    </div>
  </div>
</script>
```
For more information about templating read [CLNDR docs](https://github.com/kylestetz/CLNDR#template-requirements) or [CLNDR site](http://kylestetz.github.io/CLNDR/)


### Configure
You can precofig your Clndr by creating `initializers/clndr.rb` file.
Code below demonstrate avelible settings and theirs defaults

```

    Clndr.configure do |config|

      # you can configure default template, jast use Clndr::Template::<template_name or from_html(selector)>
      config.template = Clndr::Template::FULL

      # start the week off on Sunday (true), Monday (false)
      config.week_offset = false

      # determines which month to start with using either a date string in format `YYYY-MM-DD`, instance of `Time` class or `nil` (if use nil Clndr will use current month)
      config.start_with_month = nil

      # Array of days ['M','T','W','T','F','S','S'] or nil (use moment() object)
      config.days_of_the_week =nil

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
       config.constraints_start= Time.now
       config.constraints_end= Time.now
```

###i18n
You can internationalize calendars by include moment.js locale file

 ```
 //=require moment/ru
 ```
 Now date format will be for Russia

This project rocks and uses MIT-LICENSE.