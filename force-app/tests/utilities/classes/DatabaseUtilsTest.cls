/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2019-03-13 : Gavin Palmer - Original
 **/
@IsTest(isParallel=true)
private class DatabaseUtilsTest {
    @IsTest
    private static void getErrorStringTest() {
        Database.SaveResult insertResult = Database.insert(new Account(), false);

        System.assert(
            DatabaseUtils.getErrorString(insertResult.getErrors()).contains('Required'),
            'The error string should return the missing required fields error'
        );
    }
}
