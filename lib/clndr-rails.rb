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
  include ActiveSupport::Inflector


  # return calendar from calendars bean
  def self.get_calendar(calendar)
    ObjectSpace.each_object(self) {|cal| return cal if cal.name.to_sym == calendar  }
  end

  attr_accessor :template, :weak_offset, :days_of_the_weak,:show_adjacent_months, :adjacent_days_change_month, :done_rendering
  attr_reader :name



  def initialize(name)
    @name = name.to_s
    @template = @@template
    @weak_offset = @@weak_offset
    @start_with_month =@@start_with_month
    @days_of_the_weak = @@days_of_the_weak
    @click_events = @@click_events.clone
    @targets= @@targets.clone
    @show_adjacent_months= @@show_adjacent_months
    @adjacent_days_change_month = @@adjacent_days_change_month
    @done_rendering = @done_rendering
  end

  #   return html of calendar
  def view(args)
    content_tag(:div,nil,args)do
      content_tag(:div,nil,id:"#{@name}-clndr",class:'clearfix')+
      javascript_tag("$('##{@name}-clndr').clndr({
        #{'template:'+@template+',' if !@template.nil?}
        #{'weekOffset:'+@weak_offset.to_s+',' if @weak_offset}
        #{'startWithMonth:\''+@start_with_month.to_s+'\',' if !@start_with_month.nil?}
        #{'daysOfTheWeek:'+@days_of_the_weak.to_s+',' if !@days_of_the_weak.nil?}
        #{build_from_hash(@click_events,'clickEvent')}
        #{build_from_hash_safety(@targets,'targets')}
        #{'showAdjacentMonths:'+@show_adjacent_months.to_s+',' if !@show_adjacent_months}
        #{'adjacentDaysChangeMonth:'+@adjacent_days_change_month.to_s+',' if @adjacent_days_change_month}
        #{'doneRendering:'+@done_rendering+',' if !@done_rendering.nil?}
          });")
      end
  end

  # if date is instance of Time convert to "YYYY-MM-DD" формат
  def start_with_month=(date)
    if date.class == Time
      @start_with_month= date.strftime("%F")
    else
      @start_with_month = date
    end
  end

  def click_event
    @click_events
  end

  def target
    @targets
  end

  private

    def build_from_hash(hash, parametr)
      if hash.length > 0
        "#{parametr}: {#{hash.map{|k,v|"#{k}:#{v},"}.join()}},"
      end
    end

  def build_from_hash_safety(hash, parametr)
    if hash.length > 0
      "#{parametr}: {#{hash.map{|k,v|"#{k}:'#{v}',"}.join()}},"
    end
  end
end
