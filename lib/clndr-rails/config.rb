class Clndr

  # default config
  @@template = Clndr::Template::Blank
  @@weak_offset = true


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

end