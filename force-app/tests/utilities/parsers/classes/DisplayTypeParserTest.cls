/**
 * @author Gavin Palmer
 * @date 2019-03-23
 *
 **/
@isTest(isParallel=true)
private class DisplayTypeParserTest {
    @isTest
    private static void parseTestStringValue() {
        final String valueToParse = 'value to parse';
        Parsable parser = new DisplayTypeParser(DisplayType.TEXTAREA);
        Object parsedValue = parser.parse(valueToParse);
        Assert.isInstanceOfType(
            parsedValue, String.class,
            'The field should have been parsed to a string'
        );

        Assert.areEqual(
            valueToParse,
            (String) parsedValue,
            'The string value should not have changed when parsed'
        );
    }

    @isTest
    private static void parseTestNumberValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DOUBLE);
        Object parsedValue = parser.parse('3.3');

        Assert.isInstanceOfType(
            parsedValue, Decimal.class,
            'The field should have been parsed to a decimal'
        );

        Assert.areEqual(3.3, (Decimal) parsedValue, 'The value shold have been parsed to 3.3');
    }

    @isTest
    private static void parseTestDateValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATE);
        Object parsedValue = parser.parse('1993-06-29');

        Assert.isInstanceOfType(parsedValue, Date.class, 'The field should have been parsed to a date');

        Assert.areEqual(
            Date.newInstance(1993, 6, 29),
            (Date) parsedValue,
            'The date should have been parsed'
        );
    }

    @isTest
    private static void parseTestDatetimeValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATETIME);
        Object parsedValue = parser.parse('1993-06-29 10:10:10');

        Assert.isInstanceOfType(
            parsedValue, Datetime.class,
            'The field should have been parsed to a datetime'
        );

        Assert.areEqual(
            Datetime.newInstance(1993, 6, 29, 10, 10, 10),
            (Datetime) parsedValue,
            'The datetime should have been parsed'
        );
    }

    @isTest
    private static void parseTestBooleanValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.BOOLEAN);
        Object parsedValue = parser.parse('true');

        Assert.isInstanceOfType(
            parsedValue, Boolean.class,
            'The field should have been parsed to a boolean'
        );

        Assert.isTrue((Boolean) parsedValue, 'The boolean should have been parsed');
    }

    @isTest
    private static void parseTestIdValue() {
        Parsable parser = new DisplayTypeParser(DisplayType.ID);
        Object parsedValue = parser.parse(UserInfo.getUserId());

        Assert.isInstanceOfType(parsedValue, Id.class, 'The field should have been parsed to an id');

        Assert.areEqual(
            UserInfo.getUserId(),
            (Id) parsedValue,
            'The user Id should have been parsed'
        );
    }

    @isTest
    private static void parseTestInvalidDisplayType() {
        Parsable parser = new DisplayTypeParser(DisplayType.DATE);
        try {
            parser.parse('Invalid date');
            Assert.fail('An exception should be thrown for an invalid display type');
        } catch (Exception exceptionToCheck) {
            Assert.isTrue(
                exceptionToCheck.getMessage().containsIgnoreCase('invalid date'),
                'An exception should be thrown when specifying date when the input is not a date type'
            );
        }
    }
}
