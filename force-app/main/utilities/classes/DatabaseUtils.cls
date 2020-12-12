/**
 * @author Gavin Palmer
 * @date 2019-03-13
 * @description This class is a utility for the Database class
 *
 **/
public inherited sharing class DatabaseUtils {
    public static String errorStringSeperator = '\n';

    /**
     * @author Gavin Palmer
     * @description This class is a utility for the Database class
     *
     **/
    public static String getErrorString(List<Database.Error> errors) {
        final StringBuilder fullErrors = new StringBuilder();
        fullErrors.setSeparator(errorStringSeperator);
        for (Database.Error error : errors) {
            fullErrors.append(error.getMessage());
        }
        return fullErrors.toString();
    }
}
