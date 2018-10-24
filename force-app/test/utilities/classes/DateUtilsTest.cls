/*
 Test class for the DateUtils class
*/
@isTest
private class DateUtilsTest {

    @isTest
    private static void getNow() {
        System.assertEquals(
            Datetime.now(), DateUtils.getNow(),
            'The date utils should return the current date time if one is not set previously'
        );
    }

    @isTest
    private static void getToday() {
        System.assertEquals(
            Date.today(), DateUtils.getToday(),
            'The date utils should return the current date if one is not set previously'
        );
    }

    @isTest
    private static void getNowPriorDateSet() {
        Datetime aDatetime = Datetime.newInstance(1023333);
        DateUtils.setNow(aDatetime);
        System.assertEquals(
            aDatetime, DateUtils.getNow(),
            'The date utils should return the set date time if is is set previously'
        );
    }

    @isTest
    private static void getTodayPriorDateSet() {
        Date aDate = Date.newInstance(1993, 06, 29);
        DateUtils.setToday(aDate);
        System.assertEquals(
            aDate, DateUtils.getToday(),
            'The date utils should return the set date if it is set previously'
        );
    }
}