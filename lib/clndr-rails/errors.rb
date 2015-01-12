class Clndr
  module Error
    class CalendarNotFound <StandardError

      #this error raise when calendar not found
    end

    class WrongDateFormat <StandardError
      def message
       "Clndr support Ruby Time object or date string format 'YYYY-MM-DD' "
      end
    end

    class WrongDaysOfWeekArray <StandardError
      def message
        "Array of days must contain 7 elements"
      end
    end
  end
end