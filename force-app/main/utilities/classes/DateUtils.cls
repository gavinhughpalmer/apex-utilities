/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This class will be used for reusable date functions
*
* 2019-03-11 : Gavin Palmer - Original
**/
public without sharing class DateUtils {
    
    private static Datetime now;
    private static Date today;

    public static Datetime getNow() {
        return now == null ? Datetime.now() : now;
    }

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
    
    public static Date toEndOfMonth(final Date input) {
        final Integer lastDayOfMonth = Date.daysInMonth(input.year(), input.month());
        return Date.newInstance(input.year(), input.month(), lastDayOfMonth);
    }
}
