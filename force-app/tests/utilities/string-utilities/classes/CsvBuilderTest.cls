/**
 * @author Gavin Palmer
 *
 * @date 2019-03-23
 **/
@isTest(isParallel=true)
private class CsvBuilderTest {
    @isTest
    private static void appendFieldTest() {
        final String fieldName = 'Name';
        final String fieldValue = 'Gavin';
        CsvBuilder testCsv = new CsvBuilder();
        testCsv.appendField(fieldName, fieldValue);

        System.assert(
            testCsv.headerToValues.containsKey(fieldName),
            'The csv should have the header value in it'
        );
        System.assertEquals(
            1,
            testCsv.headerToValues.get(fieldName).size(),
            'The column should have a single value in it'
        );
        System.assertEquals(
            fieldValue,
            testCsv.headerToValues.get(fieldName).get(0),
            'The field value should match the one that is set in the function call'
        );
    }

    @isTest
    private static void newRowTest() {
        final String fieldName = 'Name';
        final String fieldValue = 'Gavin';
        CsvBuilder testCsv = new CsvBuilder();
        testCsv.appendField(fieldName, fieldValue);
        testCsv.newRow();
        testCsv.appendField(fieldName, fieldValue);

        System.assert(
            testCsv.headerToValues.containsKey(fieldName),
            'The csv should have the header value in it'
        );
        System.assertEquals(
            2,
            testCsv.headerToValues.get(fieldName).size(),
            'The column should have a 2 rows after addRow is called'
        );
        System.assertEquals(
            fieldValue,
            testCsv.headerToValues.get(fieldName).get(0),
            'The field value should match the one that is set in the function call'
        );
        System.assertEquals(
            fieldValue,
            testCsv.headerToValues.get(fieldName).get(1),
            'The field value should match the one that is set in the function call'
        );
    }

    @isTest
    private static void toStringTest() {
        final String lineEnding = CsvBuilder.WINDOWS_LINE_ENDING;
        CsvBuilder testCsv = new CsvBuilder(lineEnding);
        testCsv.appendField('Column1', 'value11');
        testCsv.appendField('Column2', 'value12');
        testCsv.newRow();
        testCsv.appendField('Column2', 'value22');

        String csvContent = testCsv.toString();

        System.assertEquals(
            'Column1,Column2' +
            lineEnding +
            'value11,value12' +
            lineEnding +
            ',value22',
            csvContent,
            'The content of the CSV builder should have been converted into a csv document'
        );
    }

    @isTest
    private static void nullHeaderTest() {
        CsvBuilder testCsv = new CsvBuilder();
        testCsv.appendField(null, 'value11');

        String csvContent = testCsv.toString();

        System.assertEquals(
            'null' +
            CsvBuilder.UNIX_LINE_ENDING +
            'value11',
            csvContent,
            'A null header value should result in the string null in the header'
        );
    }

    @isTest
    private static void nullValueTest() {
        CsvBuilder testCsv = new CsvBuilder();
        testCsv.appendField('Header', null);

        String csvContent = testCsv.toString();

        System.assertEquals(
            'Header' +
            CsvBuilder.UNIX_LINE_ENDING +
            'null',
            csvContent,
            'A null field value should result in the string null in the field'
        );
    }
}
