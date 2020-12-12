/**
 * @author Gavin Palmer
 * @description This class is intended to extend the usage of the standard System.assert methods in salesforce,
 * the class has been anotated with @IsTest because it is untestable due to the assert statement
 *
 * @date 2018-06-27
 **/
@SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
public class Assert {
    public static void pageMessage(final String expectedPageMessage) {
        hasPageMessages();

        Boolean containsMessage = false;
        for (ApexPages.Message message : ApexPages.getMessages()) {
            String actualErrorMessage = message.getSummary();
            if (actualErrorMessage.containsIgnoreCase(expectedPageMessage)) {
                containsMessage = true;
                break;
            }
        }
        System.assert(
            containsMessage,
            'The message \'' +
            expectedPageMessage +
            '\' was not found in the page messages. Actual: ' +
            ApexPages.getMessages()
        );
    }

    public static void hasPageMessages() {
        System.assert(ApexPages.hasMessages(), 'There are no messages on the page');
    }

    public static void doesNotHavePageMessages() {
        System.assert(
            !ApexPages.hasMessages(),
            'There are messages visible on the page: ' + getPageMessagesString()
        );
    }

    private static String getPageMessagesString() {
        StringBuilder pageMessages = new StringBuilder();
        pageMessages.setSeparator('\n');
        for (ApexPages.Message message : ApexPages.getMessages()) {
            pageMessages.append(message.getSummary());
        }
        return pageMessages.toString();
    }

    public static void contains(String fullString, String substring) {
        System.assert(
            fullString.contains(substring),
            'The string (' +
            substring +
            ') was not found in the string: ' +
            fullString
        );
    }

    public static void fail(String message) {
        System.assert(false, message);
    }
}
