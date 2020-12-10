/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Parsable interface will be implemented by classes that are intended to parse a string to an object value
 *
 * 2019-03-23 : Gavin Palmer - Original
 **/
public interface Parsable {
    Object parse(String stringToParse);
}
