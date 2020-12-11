/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @description Parsable interface will be implemented by classes that are intended to parse a string to an object value
 *
 * @date 2019-03-23
 **/
public interface Parsable {
    Object parse(String stringToParse);
}
