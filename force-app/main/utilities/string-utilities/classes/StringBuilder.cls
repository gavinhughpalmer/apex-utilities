/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @description In Apex String is an immutable object, meaning that whenever you wish to append to a string you are creating a new instance of the object,
 * string builder mitigates this by only generating the string when it is needed. This class can be useful when joining a large number of strings together
 * Usage:
 * StringBuilder text = new StringBuilder();
 * for (Integer i = 0; i < 10; i++) {
 *     text.append(String.valueOf(i));
 * }
 * System.debug(text.toString());
 *
 * @date 2018-06-28
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

    // public StringBuilder(Boolean uniqueBuffer) {
    //     if (uniqueBuffer) {
    //         buffer = new Set<String>();
    //     } else {
    //         this();
    //     }
    // }

    public StringBuilder(Object value) {
        this();
        append(value);
    }

    public StringBuilder append(String value) {
        if (value != null) {
            buffer.add(value);
            count += value.length(); // This isn't correct if the buffer is unique
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

    public Integer capacity() {
        return buffer.size();
    }

    public Integer length() {
        return count + (separator.length() * (capacity() - 1));
    }

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
