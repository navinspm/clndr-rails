class Clndr
module Helpers
  def show_calendar(scope)
    Clndr.get_calendar(scope.to_sym).view
  end
end
end