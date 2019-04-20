/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description In Apex String is an immutable object, meaning that whenever you wish to append to a string you are creating a new instance of the object,
* string builder mitigates this by only generating the string when it is needed. This class can be useful when joining a large number of strings together
* Usage:
* StringBuilder text = new StringBuilder();
* for (Integer i = 0; i < 10; i++) {
*     text.append(String.valueOf(i));
* }
* System.debug(text.toString());
*
* 2018-06-28 : Gavin Palmer - Original
**/
public virtual inherited sharing class StringBuilder {

    @testVisible private final List<String> buffer = new List<String>();
    @testVisible private String separator = '';

    @SuppressWarnings('PMD.EmptyStatementBlock')
    public StringBuilder() {}

    public StringBuilder(Object value) {
        append(value);
    }

    public StringBuilder append(String value) {
        if (value != null) {
            buffer.add(value);
        }
        return this;
    }

    public StringBuilder append(Object value) {
        String stringValue = String.valueOf(value);
        return append(stringValue);
    }

    public void setSeparator(String separator) {
        if (String.isNotEmpty(separator)) {
            this.separator = separator;
        }
    }

    public Integer length() {
        return buffer.size();
    }

    public override String toString() {
        return String.join(buffer, separator);
    }
}