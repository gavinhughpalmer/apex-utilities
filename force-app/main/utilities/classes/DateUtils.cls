/*
 The date utils class provides a wrapper around the standard date + datetime classes to allow users to set the current date from within test classes
 this can be useful for any time dependant tests
*/
public class DateUtils {

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
}