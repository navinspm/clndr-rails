  module Helpers
    def show_calendar(scope,*args)
      Clndr.get_calendar(scope.to_sym).view(args.first)
    end
  end