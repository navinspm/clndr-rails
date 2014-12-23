class Clndr

  # default config
  @@template = Clndr::Template::Blank
  @@week_offset = true
  @@start_with_month = nil
  @@days_of_the_week = nil
  @@click_events={}
  @@targets={}
  @@show_adjacent_months= true
  @@adjacent_days_change_month=false
  @@done_rendering=nil
  @@constraints ={}
  @@force_six_rows= true

  # todo check days of week for 7 length
  # todo check for avalible events and targets
  # rails like config
  def self.configure
    yield self
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
    if date.class == Time
      @@start_with_month=date.strftime("%F")
    elsif date.match(/\d{4}\-\d{2}\-\d{2}/)
      @@start_with_month = date
    else
      raise Clndr::Error::WrongDateFormat
    end
  end

  def self.days_of_the_week=(array_of_days)
    @@days_of_the_week=array_of_days
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
    if date.class == Time
      @@constraints[:startDate]=date.strftime("%F")
    elsif date.match(/\d{4}\-\d{2}\-\d{2}/)
      @@constraints[:startDate]=date
    else
      raise Clndr::Error::WrongDateFormat
    end
  end

  def self.constraints_end=(date)
    if date.class == Time
      @@constraints[:endDate]=date.strftime("%F")
    elsif date.match(/\d{4}\-\d{2}\-\d{2}/)
      @@constraints[:endDate]=date
    else
      raise Clndr::Error::WrongDateFormat
    end
  end

  def self.force_six_rows=(boolean)
    @@force_six_rows= boolean
  end

end