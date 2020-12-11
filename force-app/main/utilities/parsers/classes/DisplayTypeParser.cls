/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @description This parser will take a string value and convert it to the display type that is passed into the constructor
 *
 * @date 2019-03-23
 **/
public class DisplayTypeParser implements Parsable {
    private static final Map<DisplayType, Parser> PARSERS = new Map<DisplayType, Parser>{
        DisplayType.BOOLEAN => new BooleanParser(),
        DisplayType.DOUBLE => new DecimalParser(),
        DisplayType.CURRENCY => new DecimalParser(),
        DisplayType.PERCENT => new DecimalParser(),
        DisplayType.INTEGER => new DecimalParser(),
        DisplayType.DATE => new DateParser(),
        DisplayType.DATETIME => new DatetimeParser(),
        DisplayType.ID => new IdParser(),
        DisplayType.REFERENCE => new IdParser(),
        null => new StringParser()
    };

    private final Parser parser;

    public DisplayTypeParser(DisplayType type) {
        parser = PARSERS.containsKey(type) ? PARSERS.get(type) : PARSERS.get(null);
    }

    // allow errors to surface as I will not be able to provide any additional detail
    public Object parse(String value) {
        return parser.parse(value);
    }

    private abstract class Parser {
        public Object parse(String value) {
            Object parsedValue;
            if (String.isNotBlank(value)) {
                parsedValue = parseSafe(value);
            }
            return parsedValue;
        }
        protected abstract Object parseSafe(String value);
    }
    private class BooleanParser extends Parser {
        protected override Object parseSafe(String value) {
            return Boolean.valueOf(value);
        }
    }
    private class DecimalParser extends Parser {
        protected override Object parseSafe(String value) {
            return Decimal.valueOf(value);
        }
    }
    private class DateParser extends Parser {
        protected override Object parseSafe(String value) {
            return Date.valueOf(value);
        }
    }
    private class DatetimeParser extends Parser {
        protected override Object parseSafe(String value) {
            return Datetime.valueOf(value);
        }
    }
    private class IdParser extends Parser {
        protected override Object parseSafe(String value) {
            return Id.valueOf(value);
        }
    }
    private class StringParser extends Parser {
        protected override Object parseSafe(String value) {
            return String.valueOf(value);
        }
    }
}
