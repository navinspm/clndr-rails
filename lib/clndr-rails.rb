require 'clndr-rails/helpers'
require 'clndr-rails/engine'
require "clndr-rails/version"


require 'momentjs-rails'
require 'jquery-rails'
require 'underscore-rails'

class Clndr


  include ActionView::Helpers
  include ActionView::Context


  attr_reader :view

  @@calendars ={}


  def initialize(name)

    @view =content_tag(:div,nil,id:"calendar-warper"){
      content_tag(:div,nil,id:"calendar")+
      javascript_tag("$('#calendar').clndr();")}

    @@calendars[name.to_sym] = self
  end

  def self.get_calendar(calendar)
    @@calendars[calendar]
  end
end
