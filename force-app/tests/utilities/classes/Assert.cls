/**
 * @author Gavin Palmer
 * @date 2018-06-27
 * @group Test Utilities
 * @description This class is intended to extend the usage of the standard System.assert methods in salesforce,
 * the class has been anotated with @IsTest because it is untestable due to the assert statement
 *
 **/
@SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
public class Assert {

    /**
     * @description This assertion will check the page message provided exists within the page messages
     *
     **/
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

    /**
     * @description This assertion validates there is page messages provided
     **/
    public static void hasPageMessages() {
        System.assert(ApexPages.hasMessages(), 'There are no messages on the page');
    }

    /**
     * @description This assertion validates there is page not messages provided
     **/
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

    /**
     * @description This assertion will check for a string within a secondary substring, this mainly wraps to add the defult error message
     * @param fullString The full string that you wish to check
     * @param substring The substring that you are checking exists within the fullString
     **/
    public static void contains(String fullString, String substring) {
        System.assert(
            fullString.contains(substring),
            'The string (' +
            substring +
            ') was not found in the string: ' +
            fullString
        );
    }

    /**
     * @description This is a simple assertion to force a failure, can be used if an exception is expected to be thown in a test
     * @param message The message you wish to throw if this assertion is ever hit
     **/
    public static void fail(String message) {
        System.assert(false, message);
    }
}
