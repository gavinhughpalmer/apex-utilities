/**
 * @author Gavin Palmer
 * @date 2018-06-28
 * @group String Utilities
 * @description This class is intended to be similar to the java StringBuilder, it allows strings to be dynamically constructed but only assigned at the point, similar to Javas StringBuffer
 *
 **/
public virtual inherited sharing class StringBuilder {
    @testVisible
    private final List<String> buffer;
    @testVisible
    private String separator = '';
    private Integer count = 0;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    public StringBuilder() {
        buffer = new List<String>();
    }

    public StringBuilder(Object value) {
        this();
        append(value);
    }

    public StringBuilder append(String value) {
        if (value != null) {
            buffer.add(value);
            count += value.length();
        }
        return this;
    }

    public StringBuilder append(Object value) {
        String stringValue = String.valueOf(value);
        return append(stringValue);
    }

    public StringBuilder append(StringBuilder stringBuilder) {
        if (stringBuilder == null) {
            return append('null');
        }
        count += stringBuilder.count;
        buffer.addAll(stringBuilder.buffer);
        return this;
    }

    public void setSeparator(String separator) {
        if (String.isNotEmpty(separator)) {
            this.separator = separator;
        }
    }

    /**
     * @description Capacity will return the total numbe of strings in the buffer
     *
     **/
    public Integer capacity() {
        return buffer.size();
    }

    /**
     * @description Length will return the total length of the string once it is combined
     *
     **/
    public Integer length() {
        return count + (separator.length() * (capacity() - 1));
    }

    // TODO
    // delete
    // replace
    // subString
    // insert
    // indexOf
    // lastIndexOf
    // reverse

    public override String toString() {
        return String.join(buffer, separator);
    }
}
