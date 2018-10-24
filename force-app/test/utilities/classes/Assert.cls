/*
 This class is intended to extend the usage of the standard System.assert methods in salesforce,
 the class has been anotated with @isTest because it is untestable due to the assert statement
*/
@isTest
public class Assert {

    public static void pageMessage(final String expectedPageMessage) {

        System.assert(ApexPages.hasMessages(), 'There are no messages on the page');

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
}