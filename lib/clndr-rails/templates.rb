class Clndr
  module Template

    extend ActionView::Helpers::TagHelper
    extend ActionView::Context


    FullCalendar = "'#{self.content_tag(:div,nil,class:'clndr-controls') do
      self.content_tag(:div,'<',class:"clndr-previous-button")+
      self.content_tag(:div,'>',class:"clndr-next-button")+
      self.content_tag(:div,'<%= month %> <%= year %>'.html_safe,class:"current-month")
    end+

    self.content_tag(:div,nil,class:'clndr-grid') do
      self.content_tag(:div,nil, class:'days-of-the-week clearfix') do
        '<% _.each(daysOfTheWeek, function(day) { %>'.html_safe+
        self.content_tag(:div,'<%= day %>'.html_safe,class:'header-day')+"<% }); %>".html_safe
      end+
      self.content_tag(:div,nil,class:'days')do
        "<% _.each(days, function(day) { %>".html_safe+
            '<div class=\"<%= day.classes %>\" id=\"<%= day.id %>\"><span class=\"day-number\"><%= day.day %></span></div> <% }); %>'.html_safe
      end
    end+

    self.content_tag(:div,nil,class:'event-listing') do
      content_tag(:div,"EVENTS THIS MONTH", class:"event-listing-title")+
      "<% _.each(eventsThisMonth, function(event) { %>".html_safe+
      content_tag(:div,nil,class:"event-item") do
        content_tag(:div,"<%= event.title %>".html_safe, class:"event-item-name")+
        content_tag(:div,"<%= event.location %>".html_safe, class:"event-item-location")
      end+
      "<% }); %>".html_safe
    end}'"

    Blank=nil

    def self.from_html(selector)
      "$(\"#{selector}\").html()".html_safe
    end

  end
end