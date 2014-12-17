  module Helpers
    def show_calendar(scope,*args)
      clndr =Clndr.get_calendar(scope.to_sym)
          if clndr.class == Clndr
              clndr.view(args.first)
          else
            raise Clndr::Error::CalendarNotFound, "Calndear with name #{scope} not found. Use Clndr.new(:#{scope}) to create them"
          end
    end
  end