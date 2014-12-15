class Clndr

  # default config
  @@template = Clndr::Template::Blank
  @@weak_offset = true
  @@start_with_month = nil



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

  # сonvert date to
  def self.start_with_month=(date)
    if date.class == Time
      @@start_with_month=date.strftime("%F")
    elsif date.match(/\d{4}\-d{2}\-d{2}/)
      @@start_with_month
    else
      # todo resque Clndr::Errors::WrongDateFormat
    end
  end

end