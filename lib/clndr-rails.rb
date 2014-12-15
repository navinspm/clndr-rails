require 'clndr-rails/engine'
require "clndr-rails/version"

require 'momentjs-rails'
require 'jquery-rails'
require 'underscore-rails'

class Clndr

  autoload :Helpers, 'clndr-rails/helpers'
  autoload :Template, 'clndr-rails/templates'
  require 'clndr-rails/config'

  include ActionView::Helpers
  include ActionView::Context


  # return calendar from calendars bean
  def self.get_calendar(calendar)
    ObjectSpace.each_object(self) {|cal| return cal if cal.name.to_sym == calendar  }
  end

  attr_accessor :template, :weak_offset
  attr_reader :name



  def initialize(name)
    @name = name.to_s
    @template = @@template
    @weak_offset = @@weak_offset
  end

  #   return html of calendar
  def view(args)
    content_tag(:div,nil,args)do
      content_tag(:div,nil,id:"#{@name}-clndr",class:'clearfix')+
      javascript_tag("$('##{@name}-clndr').clndr({
        #{'template:'+@template+',' if !@template.nil?}
        #{'weekOffset:'+@weak_offset.to_s+',' if @weak_offset}
          });")
      end
  end

end
