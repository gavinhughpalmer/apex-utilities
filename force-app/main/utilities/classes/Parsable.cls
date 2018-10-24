/*
 Parsable interface will be implemented by classes that are intended to parse a string to an object value
*/
public interface Parsable {
    Object parse(String stringToParse);
}