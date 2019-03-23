/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description This class is a utility for the Database class
*
* 2019-03-13 : Gavin Palmer - Original
**/
public inherited sharing class DatabaseUtils {

    public static String errorStringSeperator = '\n';

    public static String getErrorString(List<Database.Error> errors) {
        final StringBuilder fullErrors = new StringBuilder();
        fullErrors.setSeparator(errorStringSeperator);
        for (Database.Error error : errors) {
            fullErrors.append(error.getMessage());
        }
        return fullErrors.toString();
    }
}
