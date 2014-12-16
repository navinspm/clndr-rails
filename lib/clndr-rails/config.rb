class Clndr

  # default config
  @@template = Clndr::Template::Blank
  @@weak_offset = true
  @@start_with_month = nil
  @@days_of_the_week = nil
  @@click_events={}
  @@targets={}
  @@show_adjacent_months= true
  @@adjacent_days_change_month=false
  @@done_rendering=nil



   def self.configure
    yield self
  end

  def self.template=(template)
    @@template ||= template
  end

  def self.weak_offset=(offset)
    if offset
      @@weak_offset = 1
    else
      @@weak_offset = 0
    end
  end

  def self.start_with_month=(date)
    if date.class == Time
      @@start_with_month=date.strftime("%F")
    elsif date.match(/\d{4}\-d{2}\-d{2}/)
      @@start_with_month
    else
      # todo resque Clndr::Errors::WrongDateFormat
    end
  end

  def self.days_of_the_weak=(array_of_days)
    @@days_of_the_weak=array_of_days
  end

  def self.show_adjacent_months=(boolean)
    @@show_adjacent_months = boolean
  end

  def self.click_events
    yield @@click_events
  end

  def self.targets
    yield @@targets
  end

  def self.adjacent_days_change_month=(boolean)
    @@adjacent_days_change_month= boolean
  end

  def self.done_rendering=(jsfnction)
    @@done_rendering = jsfnction
  end

end