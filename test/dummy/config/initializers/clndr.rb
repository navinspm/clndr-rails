Clndr.configure do |config|
  config.template = Clndr::Template::FullCalendar
  config.weak_offset = false
  config.start_with_month = Time.now+1.month
end