/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description The assert class is a utility to help in test classes, any additional assert functions can be added in here as static methods, this class is annotated with @isTest as it is a mostly untestable due to the assert statement inside it.
*
*
* 2018-06-27 : Gavin Palmer - Original
**/
@IsTest
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
            'The message \'' + expectedPageMessage + '\' was not found in the page messages. Actual: ' + ApexPages.getMessages()
        );
    }

    public static void hasPageMessages() {
        System.assert(ApexPages.hasMessages(), 'There are no messages on the page');
    }

    public static void doesNotHavePageMessages() {
        System.assert(!ApexPages.hasMessages(), 'There are messages visible on the page: ' + getPageMessagesString());
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
            'The string (' + substring + ') was not found in the string: ' + fullString
        );
    }
}