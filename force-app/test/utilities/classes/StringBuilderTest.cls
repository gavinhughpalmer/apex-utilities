@isTest
private class StringBuilderTest {

    @isTest
    private static void appendTestValidString() {
        final String expectedOutput = 'Hello';
        StringBuilder builder = new StringBuilder();
        builder.append(expectedOutput);

        System.assertEquals(
            1,
            builder.length(),
            'There should be a single string in the builder'
        );

        System.assertEquals(
            expectedOutput,
            builder.buffer[0],
            'The string in the builder should be what was appended to the string builder'
        );
    }

    @isTest
    private static void appendTestValidObject() {
        final Integer value = 1;
        StringBuilder builder = new StringBuilder(value);

        System.assertEquals(
            1,
            builder.length(),
            'There should be a single string in the builder'
        );

        System.assertEquals(
            '1',
            builder.buffer[0],
            'The string in the builder should be what was appended to the string builder'
        );
    }

    @isTest
    private static void appendTestNullString() {
        StringBuilder builder = new StringBuilder();
        String value = null;
        builder.append(value);

        System.assertEquals(
            0,
            builder.length(),
            'The empty string should not be added to be built'
        );
    }

    @isTest
    private static void setSeparatorTest() {
        final String expectedOutput = 'Hello';
        StringBuilder builder = new StringBuilder();
        builder.setSeparator(expectedOutput);

        System.assertEquals(
            expectedOutput,
            builder.separator,
            'The separator should be set by the method'
        );
    }

    @isTest
    private static void setSeparatorTestNullString() {
        StringBuilder builder = new StringBuilder();
        builder.setSeparator(null);

        System.assertEquals(
            '',
            builder.separator,
            'A null separator should not be added to the string builder'
        );
    }

    /*
    * this will test the whole process of using the string builder
    */
    @isTest
    private static void toStringTest() {
        final String expectedOutputStart = 'String';
        final String separator = '\n';
        final String expectedOutputEnd = 'Ending';

        StringBuilder builder = new StringBuilder();
        builder.append(expectedOutputStart);
        builder.append(expectedOutputEnd);
        builder.setSeparator(separator);

        System.assertEquals(
            expectedOutputStart + separator + expectedOutputEnd,
            builder.toString(),
            'The string builder should concatenate all of the strings'
        );
    }
}