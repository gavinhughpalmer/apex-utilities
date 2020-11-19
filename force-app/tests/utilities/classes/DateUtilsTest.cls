/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2019-03-11 : Gavin Palmer - Original
 **/
@IsTest
private class DateUtilsTest {
    @isTest
    private static void getNow() {
        System.assertEquals(
            Datetime.now(),
            DateUtils.getNow(),
            'The date utils should return the current date time if one is not set previously'
        );
    }

    @isTest
    private static void getToday() {
        System.assertEquals(
            Date.today(),
            DateUtils.getToday(),
            'The date utils should return the current date if one is not set previously'
        );
    }

    @isTest
    private static void getNowPriorDateSet() {
        Datetime aDatetime = Datetime.newInstance(1023333);
        DateUtils.setNow(aDatetime);
        System.assertEquals(
            aDatetime,
            DateUtils.getNow(),
            'The date utils should return the set date time if is is set previously'
        );
    }

    @isTest
    private static void getTodayPriorDateSet() {
        Date aDate = Date.newInstance(1993, 6, 29);
        DateUtils.setToday(aDate);
        System.assertEquals(
            aDate,
            DateUtils.getToday(),
            'The date utils should return the set date if it is set previously'
        );
    }

    @IsTest
    private static void toEndOfMonthTestStartOfMonth() {
        final Date startOfMonth = Date.newInstance(2019, 1, 1);
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        System.assertEquals(
            endOfMonth,
            DateUtils.toEndOfMonth(startOfMonth),
            'The end of the month should be returned when the beginning of the month is passed into the method'
        );
    }

    @IsTest
    private static void toEndOfMonthTestMidMonth() {
        final Date midMonth = Date.newInstance(2019, 1, 15);
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        System.assertEquals(
            endOfMonth,
            DateUtils.toEndOfMonth(midMonth),
            'The end of the month should be returned when the middle of the month is passed into the method'
        );
    }

    @IsTest
    private static void toEndOfMonthTestEndOfMonth() {
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        System.assertEquals(
            endOfMonth,
            DateUtils.toEndOfMonth(endOfMonth),
            'The end of the month should be returned when the end of the month is passed into the method'
        );
    }
}
