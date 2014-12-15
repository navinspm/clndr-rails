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

###Templates
CLNDR.js doesn't generate HTML,it inject data to yours template.
If you want quick start you can use built in gem templates.
All templates include in `Clndr::Template` module
Now add two templates `FullCalendar` and `MiniCalendar`, also you can use `Blank` template (it's empty template and CLNDR.js generate simple html)
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
  // you can configure default template, jast use Clndr::Template::<template_name or from_html(selector)>
  config.template = Clndr::Template::FullCalendar

  // start the week off on Sunday (true), Monday (false)
  config.weak_offset = false

  //determines which month to start with using either a date string in format `YYYY-MM-DD`, instance of `Time` class or `nil` (if use nil Clndr will use current month)
  config.start_with_month = nil

```

###i18n
You can internationalize calendars by include moment.js locale file

 ```
 //=require moment/ru
 ```
 Now date format will be for Russia

This project rocks and uses MIT-LICENSE.