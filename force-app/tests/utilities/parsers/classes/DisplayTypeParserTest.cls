/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2019-03-23 : Gavin Palmer - Original
**/
@isTest
private class DisplayTypeParserTest {
    @isTest
    private static void parseTestStringValue() {
        final String valueToParse = 'value to parse';
        Parsable parser = new DisplayTypeParser(DisplayType.TEXTAREA);
        Object parsedValue = parser.parse(valueToParse);

        System.assert(
            parsedValue instanceof String,
            'The field should have been parsed to a string'
        );

        System.assertEquals(
            valueToParse, (String) parsedValue,
            'The string value should not have changed when parsed'
        );
    }

    @isTest
    private static void parseTestNumberValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DOUBLE);
        Object parsedValue = parser.parse('3.3');

        System.assert(
            parsedValue instanceof Decimal,
            'The field should have been parsed to a decimal'
        );

        System.assertEquals(
            3.3, (Decimal) parsedValue,
            'The value shold have been parsed to 3.3'
        );
    }

    @isTest
    private static void parseTestDateValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATE);
        Object parsedValue = parser.parse('1993-06-29');

        System.assert(
            parsedValue instanceof Date,
            'The field should have been parsed to a date'
        );

        System.assertEquals(
            Date.newInstance(1993, 06, 29), (Date) parsedValue,
            'The date should have been parsed'
        );
    }

    @isTest
    private static void parseTestDatetimeValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATETIME);
        Object parsedValue = parser.parse('1993-06-29 10:10:10');

        System.assert(
            parsedValue instanceof Datetime,
            'The field should have been parsed to a datetime'
        );

        System.assertEquals(
            Datetime.newInstance(1993, 06, 29, 10, 10, 10), (Datetime) parsedValue,
            'The datetime should have been parsed'
        );
    }

    @isTest
    private static void parseTestBooleanValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.BOOLEAN);
        Object parsedValue = parser.parse('true');

        System.assert(
            parsedValue instanceof Boolean,
            'The field should have been parsed to a boolean'
        );

        System.assertEquals(
            true, (Boolean) parsedValue,
            'The boolean should have been parsed'
        );
    }

    @isTest
    private static void parseTestIdValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.ID);
        Object parsedValue = parser.parse(UserInfo.getUserId());

        System.assert(
            parsedValue instanceof Id,
            'The field should have been parsed to an id'
        );

        System.assertEquals(
            UserInfo.getUserId(), (Id) parsedValue,
            'The user Id should have been parsed'
        );
    }

    @isTest
    private static void parseTestInvalidDisplayType() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATE);
        try {
            parser.parse('Invalid date');
            System.assert(
                false,
                'An exception should be thrown for an invalid display type'
            );
        } catch (Exception exceptionToCheck) {
            System.assert(
                exceptionToCheck.getMessage().containsIgnoreCase('invalid date'),
                'An exception should be thrown when specifying date when the input is not a date type'
            );
        }
    }
}