class Clndr
  module Error
    class CalendarNotFound <StandardError

    end

    class WrongDateFormat <StandardError
      def message
       "Clndr support Ruby Time object or date string format 'YYYY-MM-DD' "
      end
    end
  end
end