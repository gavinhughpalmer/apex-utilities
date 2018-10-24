/*
 This parser will take a string value and convert it to the display type that is passed into the constructor
*/
public class DisplayTypeParser implements Parsable {

    private DisplayType fieldDisplayType;

    public DisplayTypeParser(DisplayType fieldDisplayType) {
        this.fieldDisplayType = fieldDisplayType;
    }

    // allow errors to surface as I will not be able to provide any additional detail
    public Object parse(String stringToParse) {
        Object parsedValue;
        switch on fieldDisplayType {
            when BOOLEAN {
                parsedValue = parseBoolean(stringToParse);
            } when DOUBLE, CURRENCY, PERCENT, INTEGER {
                parsedValue = parseDecimal(stringToParse);
            } when DATE {
                parsedValue = parseDate(stringToParse);
            } when DATETIME {
                parsedValue = parseDatetime(stringToParse);
            } when ID, REFERENCE {
                parsedValue = parseId(stringToParse);
            } when else {
                parsedValue = stringToParse;
            }
        }
        return parsedValue;
    }

    private Boolean parseBoolean(String valueToParse) {
        return String.isNotBlank(valueToParse) && Boolean.valueOf(valueToParse);
    }

    private Decimal parseDecimal(String valueToParse) {
        Decimal decimalToReturn;
        if (String.isNotBlank(valueToParse)) {
            decimalToReturn = Decimal.valueOf(valueToParse);
        }
        return decimalToReturn;
    }

    private Date parseDate(String valueToParse) {
        Date dateToReturn;
        if (String.isNotBlank(valueToParse)) {
            dateToReturn = Date.valueOf(valueToParse);
        }
        return dateToReturn;
    }

    private Datetime parseDatetime(String valueToParse) {
        Datetime datetimeToReturn;
        if (String.isNotBlank(valueToParse)) {
            datetimeToReturn = Datetime.valueOf(valueToParse);
        }
        return datetimeToReturn;
    }

    private Id parseId(String valueToParse) {
        Id idToReturn;
        if (String.isNotBlank(valueToParse)) {
            idToReturn = Id.valueOf(valueToParse);
        }
        return idToReturn;
    }
}