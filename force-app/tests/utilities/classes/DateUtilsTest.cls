/**
 * @author Gavin Palmer
 * @date 2019-03-11
 *
 **/
@IsTest(isParallel=true)
private class DateUtilsTest {
    @isTest
    private static void getNow() {
        Assert.isTrue(
            Datetime.now() <= DateUtils.getNow(),
            'The date utils should return the current date time if one is not set previously'
        );
    }

    @isTest
    private static void getToday() {
        Assert.isTrue(
            Date.today() <= DateUtils.getToday(),
            'The date utils should return the current date if one is not set previously'
        );
    }

    @isTest
    private static void getNowPriorDateSet() {
        Datetime aDatetime = Datetime.newInstance(1023333);
        DateUtils.setNow(aDatetime);
        Assert.areEqual(
            aDatetime,
            DateUtils.getNow(),
            'The date utils should return the set date time if is is set previously'
        );
    }

    @isTest
    private static void getTodayPriorDateSet() {
        Date aDate = Date.newInstance(1993, 6, 29);
        DateUtils.setToday(aDate);
        Assert.areEqual(
            aDate,
            DateUtils.getToday(),
            'The date utils should return the set date if it is set previously'
        );
    }

    @IsTest
    private static void toEndOfMonthTestStartOfMonth() {
        final Date startOfMonth = Date.newInstance(2019, 1, 1);
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        Assert.areEqual(
            endOfMonth,
            DateUtils.toEndOfMonth(startOfMonth),
            'The end of the month should be returned when the beginning of the month is passed into the method'
        );
    }

    @IsTest
    private static void toEndOfMonthTestMidMonth() {
        final Date midMonth = Date.newInstance(2019, 1, 15);
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        Assert.areEqual(
            endOfMonth,
            DateUtils.toEndOfMonth(midMonth),
            'The end of the month should be returned when the middle of the month is passed into the method'
        );
    }

    @IsTest
    private static void toEndOfMonthTestEndOfMonth() {
        final Date endOfMonth = Date.newInstance(2019, 1, 31);
        Assert.areEqual(
            endOfMonth,
            DateUtils.toEndOfMonth(endOfMonth),
            'The end of the month should be returned when the end of the month is passed into the method'
        );
    }
}
