class Clndr
  module Template

    extend ActionView::Helpers::TagHelper
    extend ActionView::Context

    # full template
    FULL = "'#{
              content_tag(:div,nil,class:'clndr-controls') do
              content_tag(:div,'<',class: 'clndr-previous-button') +
              content_tag(:div,'>',class: 'clndr-next-button') +
              content_tag(:div,'<%= month %> <%= year %>'.html_safe,class: 'current-month')
            end +
            content_tag(:div,nil,class:'clndr-grid full') do
              content_tag(:div,nil, class:'days-of-the-week clearfix') do
                '<% _.each(daysOfTheWeek, function(day) { %>'.html_safe +
                content_tag(:div,'<%= day %>'.html_safe,class:'header-day')+'<% }); %>'.html_safe
              end +
              content_tag(:div,nil,class:'days')do
                '<% _.each(days, function(day) { %>'.html_safe +
                    '<div class=\"<%= day.classes %>\" id=\"<%= day.id %>\"><span class=\"day-number\"><%= day.day %></span></div> <% }); %>'.html_safe
              end
            end +
            content_tag(:div,nil,class:'event-listing') do
              content_tag(:div, 'EVENTS THIS MONTH', class: 'event-listing-title') +
              '<% _.each(eventsThisMonth, function(event) { %>'.html_safe +
              content_tag(:div,nil,class: 'event-item') do
                content_tag(:div, '<%= event.title %>'.html_safe, class: 'event-item-name') +
                content_tag(:div, '<%= event.location %>'.html_safe, class: 'event-item-location')
              end +
              '<% }); %>'.html_safe
            end
            }'"

    # blank template
    # CLNDR generate simple table
    BLANK=nil

    #  mini template
    MINI = "'#{
              content_tag(:div,class:'controls') do
                content_tag(:div, '<', class: 'clndr-previous-button')+
                content_tag(:div, '<%= month %>'.html_safe, class: 'month')+
                content_tag(:div,'>',class: 'clndr-next-button')
              end+
              content_tag(:div,class: 'days-container mini') do
                content_tag(:div,class: 'days') do
                  content_tag(:div, class: 'headers') do
                    '<% _.each(daysOfTheWeek, function(day) { %>'.html_safe+
                    content_tag(:div, '<%= day %>'.html_safe, class: 'day-header')+
                    '<% }); %>'.html_safe+
                    '<% _.each(days, function(day) { %><div class="<%= day.classes %>" id="<%= day.id %>"><%= day.day %></div><% }); %>'.html_safe
                  end
                  end+
                    content_tag(:div,class: 'events') do
                      content_tag(:div,class: 'headers') do
                        content_tag(:div,'x',class: 'x-button')+
                          content_tag(:div,'EVENTS',class: 'event-header')
                      end+
                      content_tag(:div,class: 'events-list') do
                        '<% _.each(eventsThisMonth, function(event) { %>'.html_safe+
                        content_tag(:div,class: 'event') do
                          '<a href="<%= event.url %>"><%= moment(event.date).format("MMMM Do") %>: <%= event.title %></a>'.html_safe
                        end+
                        '<% }); %>'.html_safe
                      end
                    end
                  end


              }'"
    # simple template without month change control
    SIMPLE="'#{
              content_tag(:div,'<%= month %>'.html_safe,class: 'month-bar')+
              content_tag(:div,class: 'clndr-grid simple')do
                content_tag(:div, class: 'days-of-the-week clearfix') do
                  '<% _.each(daysOfTheWeek, function(day) { %>'.html_safe+
                  content_tag(:div,'<%= day %>'.html_safe,class: 'header-day')+
                  '<% }); %>'.html_safe
                end+
                content_tag(:div,class: 'days clearfix') do
                  '<% _.each(days, function(day) { %>'.html_safe+
                  '<div class="<%= day.classes %>" id="<%= day.id %>"><span class="day-number"><%= day.day %></span></div>'.html_safe+
                  '<% }); %>'.html_safe
                end
              end
              }'"

    # get template from html by selector
    def self.from_html(selector)
      "$(\"#{selector}\").html()".html_safe
    end

  end
end