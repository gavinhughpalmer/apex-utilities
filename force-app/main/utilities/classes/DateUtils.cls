/**
 * @author Gavin Palmer
 * @date 2019-03-11
 * @description This class will be used for reusable date functions
 *
 **/
public without sharing class DateUtils {
    private static Datetime now;
    private static Date today;

    /**
     * @description This method should be used be used in place of the standard datetime method, to allow date injection in test classes
     * @return The current datetime, or the one injected in a test method
     *
     **/
    public static Datetime getNow() {
        return now == null ? Datetime.now() : now;
    }

    /**
     * @description This method should be used be used in place of the standard date method, to allow date injection in test classes
     * @return The current date, or the one injected in a test method
     *
     **/
    public static Date getToday() {
        return today == null ? Date.today() : today;
    }

    @testVisible
    private static void setNow(Datetime newNow) {
        now = newNow;
    }

    @testVisible
    private static void setToday(Date newToday) {
        today = newToday;
    }

    /**
     * @description This function will return a date that is at the end of the month
     * @return A date at the end of the month
     *
     **/
    public static Date toEndOfMonth(final Date input) {
        final Integer lastDayOfMonth = Date.daysInMonth(input.year(), input.month());
        return Date.newInstance(input.year(), input.month(), lastDayOfMonth);
    }
}
