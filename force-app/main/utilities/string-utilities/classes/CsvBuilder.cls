/**
 * @author Gavin Palmer
 * @date 2018-06-28
 * @group String Utilities
 * @description The CsvBuilder is used to build csv files from some input
 *
 **/
public class CsvBuilder {
    public static final String WINDOWS_LINE_ENDING = '\r\n';
    public static final String UNIX_LINE_ENDING = '\n';

    @testVisible
    private final Map<String, Map<Integer, String>> headerToValues = new Map<String, Map<Integer, String>>();
    private Integer currentRow = 0;
    private final String lineEnding;

    public CsvBuilder(String lineEnding) {
        this.lineEnding = lineEnding;
    }

    public CsvBuilder() {
        this(UNIX_LINE_ENDING);
    }

    /**
     * @description append field will add a field into the existing CSV,
     * if nothing is added to a row for a header, it will be left blank
     * @param headerName the header name the field should be added to,
     * if the field does not exist it will be created
     * @param fieldValue The field value that should be added to the header,
     * if the field is already present on the current row it will be overidden
     *
     **/
    public CsvBuilder appendField(String headerName, String fieldValue) {
        headerName = String.isBlank(headerName) ? 'null' : headerName;
        fieldValue = String.isBlank(fieldValue) ? 'null' : fieldValue;
        Map<Integer, String> column = headerToValues.containsKey(headerName)
            ? headerToValues.get(headerName)
            : new Map<Integer, String>();
        column.put(currentRow, fieldValue);
        headerToValues.put(headerName, column);
        return this;
    }

    /**
     * @description This method will move the CSV to processing a new row
     **/
    public CsvBuilder newRow() {
        currentRow++;
        return this;
    }

    public Integer totalRows() {
        return headerToValues.values() != null ? headerToValues.values().size() : 0;
    }

    public override String toString() {
        ColumnBuilder csvDocument = new ColumnBuilder(lineEnding);
        RowBuilder headerRow = new RowBuilder();
        RowBuilder[] rows = new List<RowBuilder>(totalRows());
        for (String headerName : headerToValues.keySet()) {
            headerRow.append(headerName);
            Map<Integer, String> values = headerToValues.get(headerName);
            for (Integer rowIterator = 0; rowIterator <= currentRow; rowIterator++) {
                String value = values.containsKey(rowIterator) ? values.get(rowIterator) : '';
                RowBuilder row = rows[rowIterator];
                if (row == null) {
                    row = new RowBuilder();
                }
                row.append(value);
                rows[rowIterator] = row;
            }
        }
        csvDocument.append(headerRow);
        for (RowBuilder row : rows) {
            csvDocument.append(row);
        }
        return csvDocument.toString();
    }

    private class RowBuilder extends StringBuilder {
        public RowBuilder() {
            setSeparator(',');
        }
    }

    private class ColumnBuilder extends StringBuilder {
        private Integer numberOfColumns;

        public ColumnBuilder(String lineEnding) {
            setSeparator(lineEnding);
        }

        public ColumnBuilder append(RowBuilder rowToAdd) {
            Boolean isAddedRowValid =
                numberOfColumns == null ||
                rowToAdd.capacity() == numberOfColumns;
            if (!isAddedRowValid) {
                throw new InvalidRowException(
                    'The number of columns provided does not match those already in the csv'
                );
            }
            numberOfColumns = rowToAdd.capacity();
            append(rowToAdd.toString());
            return this;
        }
    }

    public class InvalidRowException extends Exception {
    }
}
