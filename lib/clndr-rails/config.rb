class Clndr

  # check date to available format
  # if date is Time instance, convert to available string
  def self.date_format(date)
    if date.is_a?(Time)
      date.strftime('%F')
    elsif date.match(/\d{4}\-\d{2}\-\d{2}/)
      date
    else
      raise Clndr::Error::WrongDateFormat
    end
  end

  # default config
  @@template = Clndr::Template::BLANK
  @@week_offset = 1
  @@start_with_month = nil
  @@days_of_the_week = nil
  @@click_events={}
  @@targets={}
  @@show_adjacent_months= true
  @@adjacent_days_change_month=false
  @@done_rendering=nil
  @@constraints ={}
  @@force_six_rows= true
  @@custom_classes = {}
  # todo check for available events and targets
  # rails like config
  def self.configure
    yield self
  end

  def self.default_settings
    @@template = Clndr::Template::BLANK
    @@week_offset = 1
    @@start_with_month = nil
    @@days_of_the_week = nil
    @@click_events={}
    @@targets={}
    @@show_adjacent_months= true
    @@adjacent_days_change_month=false
    @@done_rendering=nil
    @@constraints ={}
    @@force_six_rows= true
    @@custom_classes = {}
    self
  end


  def self.template=(template)
    @@template ||= template
  end

  def self.week_offset=(offset)

    # convert offset to CLNDR format
    if offset
      @@week_offset = 1
    else
      @@week_offset = 0
    end
  end

  def self.start_with_month=(date)
    @@start_with_month = date_format date
  end

  def self.days_of_the_week=(array_of_days)
    if array_of_days.length == 7
      @@days_of_the_week=array_of_days
    else
      raise Clndr::Error::WrongDaysOfWeekArray
    end
  end

  def self.show_adjacent_months=(boolean)
    @@show_adjacent_months = boolean
  end

  # access to click_events hash
  def self.click_events
    yield @@click_events
  end

  # access to target hash
  def self.targets
    yield @@targets
  end

  def self.adjacent_days_change_month=(boolean)
    @@adjacent_days_change_month= boolean
  end

  def self.done_rendering=(jsfunction)
    @@done_rendering = jsfunction
  end

  def self.constraints_start=(date)
    @@constraints[:startDate]= date_format date
  end

  def self.constraints_end=(date)
    @@constraints[:endDate]= date_format date
  end

  def self.force_six_rows=(boolean)
    @@force_six_rows= boolean
  end

  def self.classes
    yield @@custom_classes
  end

end