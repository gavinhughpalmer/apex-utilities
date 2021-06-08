/**
 * @author Gavin Palmer
 * @date 2019-03-13
 * @description This class is a utility for the Database class
 *
 **/
public inherited sharing class DatabaseUtils {
    /**
     * @description This is the seperator to be used when concatenating the string, defaults to unix new line character
     */
    public static String errorStringSeperator = '\n';

    /**
     * @description This function will concatenate the errors output from the database actions
     * @param errors a list of database errors that are to be concatenated
     * @return a concatenated list of the errors passed into the function
     * @example
     * Database.SaveResult results = Database.insert(newAccount, false);
     * String errors = DatabaseUtils.getErrorString(results.getErrors());
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
