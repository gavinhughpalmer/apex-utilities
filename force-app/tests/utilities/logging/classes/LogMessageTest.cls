/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2020-11-20
 **/
@IsTest(isParallel=true)
private class LogMessageTest {
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void messageConstructorTest() {
        final String expectedMessage = 'This is my message';
        LogMessage message = new LogMessage(expectedMessage);
        Assert.contains(message.toString(), expectedMessage);
        Assert.contains(message.toString(), LogMessageTest.class.getName());
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void exceptionConstructorTest() {
        final String expectedMessage = 'This is my message';
        LogMessage message = new LogMessage(new DmlException(expectedMessage));
        Assert.contains(message.toString(), expectedMessage);
        Assert.contains(message.toString(), LogMessageTest.class.getName());
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void getStackTraceTest() {
        LogMessage message = new LogMessage('Test');
        Assert.contains(message.getStackTraceString(), LogMessageTest.class.getName());
    }
}
