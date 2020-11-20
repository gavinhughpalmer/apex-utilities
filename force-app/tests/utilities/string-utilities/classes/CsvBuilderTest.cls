/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2019-03-23 : Gavin Palmer - Original
 **/
@isTest(isParallel=true)
private class CsvBuilderTest {
    //TODO negative tests...

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
}
