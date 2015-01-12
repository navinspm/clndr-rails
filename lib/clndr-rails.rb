require 'clndr-rails/engine'
require 'clndr-rails/version'
require 'clndr-rails/errors'


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
  @@calendar_basket = {}
  cattr_reader :calendar_basket

  class << self

    # return calendar from calendars bean
    def get_calendar(calendar)
      clndr = @@calendar_basket[calendar.to_sym]
      if clndr.class == Clndr
        clndr
      else
        raise Clndr::Error::CalendarNotFound, "Calendar with name #{calendar} not found. Use Clndr.new(:#{calendar}) to create them"
      end
    end
  end

  attr_accessor :template, :week_offset, :days_of_the_week,
                :show_adjacent_months, :adjacent_days_change_month,
                :done_rendering, :force_six_rows, :start_with_month
  attr_reader :name, :events



  def initialize(name)
    @name = name.to_sym
    @template = @@template
    @week_offset = @@week_offset
    @start_with_month =@@start_with_month
    @days_of_the_week = @@days_of_the_week
    @click_events = @@click_events.clone
    @targets= @@targets.clone
    @show_adjacent_months= @@show_adjacent_months
    @adjacent_days_change_month = @@adjacent_days_change_month
    @done_rendering = @@done_rendering
    @constraints =@@constraints
    @force_six_rows =@@force_six_rows
    @custom_classes = @@custom_classes
    @has_multiday= false
    @events =[]
    @@calendar_basket.merge! Hash[@name,self]
  end

  #   return html of calendar
  def view(args=nil)

    case @template
      when Clndr::Template::FULL
        css_class = 'full-clndr-template'
      when Clndr::Template::MINI
        css_class = 'mini-clndr-template'
      when Clndr::Template::SIMPLE
        css_class = 'simple-clndr-template'
      else
        css_class = 'blank-clndr-template'
    end

    content_tag(:div,nil,args)do
      content_tag(:div,nil,id:"#{@name}-clndr",class:"clearfix #{css_class}")+
      javascript_tag("var #{@name} = $('##{@name}-clndr').clndr({
        #{'template:'+@template+',' unless @template.nil?}
        #{'weekOffset:'+@week_offset.to_s+',' if @week_offset==1}
        #{'startWithMonth:\''+@start_with_month.to_s+'\',' unless @start_with_month.nil?}
        #{'daysOfTheWeek:'+@days_of_the_week.to_s+',' unless @days_of_the_week.nil?}
        #{build_from_hash(@click_events,'clickEvents')}
        #{build_from_hash(@targets,'targets',true)}
        #{'showAdjacentMonths:'+@show_adjacent_months.to_s+',' unless @show_adjacent_months}
        #{'adjacentDaysChangeMonth:'+@adjacent_days_change_month.to_s+',' if @adjacent_days_change_month}
        #{'doneRendering:'+@done_rendering+',' unless @done_rendering.nil?}
        #{'forceSixRows:'+@force_six_rows.to_s+',' if @force_six_rows}
        #{build_from_hash(@custom_classes, 'classes',true)}
        #{ if @constraints.length >0
             build_from_hash @constraints, 'constraints', true
           end}
        #{if @has_multiday
          "multiDayEvents: {
            startDate: 'startDate',
            endDate: 'endDate'
          },"
                   end}
        #{if @events.length > 0
            'events:['+build_events+']'
          end}
          });".gsub(/\n\s*\n/,"\n"))


      end
  end

  def week_offset=(boolean)
    if boolean
      @week_offset=1
    else
      @week_offset =0
    end
  end

  # if date is instance of Time convert to "YYYY-MM-DD" format
  def start_with_month=(date)
      @start_with_month = Clndr.date_format date
  end

  # access to click_events hash
  def click_event
    @click_events
  end

  # access to targets hash
  def target
    @targets
  end

  def constraints_start
    @constraints[:startDate]
  end

  def constraints_start=(date)
    @constraints[:startDate] = Clndr.date_format date
  end

  def constraints_end
    @constraints[:endDate]
  end

  def constraints_end=(date)
    @constraints[:endDate] = Clndr.date_format date
  end

  def custom_classes
    @custom_classes
  end

  def custom_today_class=(css_class)
    @custom_classes[:today]=css_class
  end

  def custom_event_class=(css_class)
    @custom_classes[:event]=css_class
  end
  def custom_past_class=(css_class)
    @custom_classes[:past]=css_class
  end

  def custom_last_month_class=(css_class)
    @custom_classes[:lastMonth]=css_class
  end

  def custom_next_month_class=(css_class)
    @custom_classes[:nextMonth]=css_class
  end

  def custom_adjacent_month_class=(css_class)
    @custom_classes[:adjacentMonth]=css_class
  end

  def custom_inactive_class=(css_class)
    @custom_classes[:inactive]=css_class
  end

  # add event to events array
  # *other_data some data for tour access in template
  def add_event(date,title,*other_data)
    date = Clndr.date_format date
    event = {date: date,title:title}
    event.merge! *other_data if other_data.length>0
    @events.push event

  end

  # add multiday event
  def add_multiday_event(start_date,end_date,title,*other_data)
    start_date = Clndr.date_format start_date
    end_date = Clndr.date_format end_date
    event = {start_date:start_date,end_date:end_date,title:title}
    event.merge! *other_data if other_data.length >0
    @has_multiday ||= true
    @events.push event
  end

  private

    # build string from hash to parameter
    # this unsafe method use only for function or true/false value
    # if you need generate js string (eg param:'some value') use
    # .build_from_hash_safety
    def build_from_hash(hash, parameter,safety=false)
      if hash.length > 0
        "#{parameter}: {#{hash.map { |k, v| "#{k}:#{'\'' if safety}#{v}#{'\'' if safety}," }.join}},"
      end
    end


  # generate events array from @event
  def build_events
    list_of_events=''
    @events.delete_if do |event|
      list_of_events +="{
          #{'date:\''+event.delete(:date)+'\',' unless event[:date].nil?}
          #{'startDate: \''+event.delete(:start_date)+'\','+
              'endDate: \'' + event.delete(:end_date)+'\',' unless event[:start_date].nil?}
          title: '#{event.delete(:title).gsub("'","&quot")}',
          #{event.map{|k,v| "#{k}:'#{v.gsub("'","&quot")}'"}.join(',')}},".gsub(/\n\s*\n/,"\n")

    end

    # return string with events
    list_of_events
  end
end

