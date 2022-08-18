/**
 * @author Gavin Palmer
 * @date 2020-11-20
 *
 **/
@IsTest(isParallel=true)
private class LogMessageTest {
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void messageConstructorTest() {
        final String expectedMessage = 'This is my message';
        LogMessage message = new LogMessage(expectedMessage);
        Assert.isTrue(
            message.toString().contains(expectedMessage),
            'The string (' +
            expectedMessage +
            ') was not found in the string: ' +
            message.toString()
        );
        Assert.isTrue(
            message.toString().contains(LogMessageTest.class.getName()),
            'The string (' +
            LogMessageTest.class.getName() +
            ') was not found in the string: ' +
            message.toString()
        );
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void exceptionConstructorTest() {
        final String expectedMessage = 'This is my message';
        LogMessage message = new LogMessage(new DmlException(expectedMessage));
        Assert.isTrue(
            message.toString().contains(expectedMessage),
            'The string (' +
            expectedMessage +
            ') was not found in the string: ' +
            message.toString()
        );
        Assert.isTrue(
            message.toString().contains(LogMessageTest.class.getName()),
            'The string (' +
            LogMessageTest.class.getName() +
            ') was not found in the string: ' +
            message.toString()
        );
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void getStackTraceTest() {
        LogMessage message = new LogMessage('Test');
        Assert.isTrue(
            message.getStackTraceString().contains(LogMessageTest.class.getName()),
            'The string (' +
            LogMessageTest.class.getName() +
            ') was not found in the string: ' +
            message.getStackTraceString()
        );
    }
}
