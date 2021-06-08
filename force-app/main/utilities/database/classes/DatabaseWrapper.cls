// Could include some of the error handling that is normally used in database methods, eg adding an error to the input record, potentially with some way of extending and adding additional error handling for specific use cases
// Log on error as some kind of parameter or method so that if the calling class just wants to log the error no boilerplate code needs to be written
// get success vs get failure methods so these can be operated on seperately
public inherited sharing class DatabaseWrapper {

    private DmlResultHandler successHandler;
    private DmlResultHandler failureHandler;

    public DatabaseResult save(SObject sObjectToSave) {
        if (String.isBlank(sObjectToSave.Id)) {
            return insertRecord(sObjectToSave);
        } else {
            return updateRecord(sObjectToSave);
        }
    }

    public DatabaseResult.InsertResult insertRecord(SObject sObjectToInsert) {
        DatabaseResult result = new DatabaseResult.InsertResult(Database.insert(sObjectToInsert, false), sObjectToInsert);
        handleResults(result);
        return (DatabaseResult.InsertResult) result;
    }

    public DatabaseResult.UpdateResult updateRecord(SObject sObjectToUpdate) {
        DatabaseResult result = new DatabaseResult.UpdateResult(Database.update(sObjectToUpdate, false), sObjectToUpdate);
        handleResults(result);
        return (DatabaseResult.UpdateResult) result;
    }

    public DatabaseResult.UpsertResult upsertRecord(SObject sObjectToUpsert) {
        DatabaseResult result = new DatabaseResult.UpsertResult(Database.upsert(sObjectToUpsert, false), sObjectToUpsert);
        handleResults(result);
        return (DatabaseResult.UpsertResult) result;
    }

    public DatabaseResult.DeleteResult deleteRecord(SObject sObjectToDelete) {
        DatabaseResult result = new DatabaseResult.DeleteResult(Database.delete(sObjectToDelete, false), sObjectToDelete);
        handleResults(result);
        return (DatabaseResult.DeleteResult) result;
    }

    public DatabaseResult.UndeleteResult undeleteRecord(SObject sObjectToUndelete) {
        DatabaseResult result = new DatabaseResult.UndeleteResult(Database.undelete(sObjectToUndelete, false), sObjectToUndelete);
        handleResults(result);
        return (DatabaseResult.UndeleteResult) result;
    }

    private void handleResults(DatabaseResult result) {
        if (result.isSuccess) {
            successHandler.handle(result);
        } else {
            failureHandler.handle(result);
        }
    }
}