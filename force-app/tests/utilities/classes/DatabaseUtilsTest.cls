/**
 * @author Gavin Palmer
 * @date 2019-03-13
 *
 **/
@IsTest(isParallel=true)
private class DatabaseUtilsTest {
    @IsTest
    private static void getErrorStringTest() {
        Database.SaveResult insertResult = Database.insert(new Account(), false);
        Assert.isTrue(
            DatabaseUtils.getErrorString(insertResult.getErrors()).contains('Required'),
            'The error string should return the missing required fields error'
        );
    }
}
