public abstract inherited sharing class DatabaseResult {
    public final Id recordId;
    public final Boolean isSuccess;
    private final List<Database.Error> errors;
    public final SObject originSObject;


    public DatabaseResult(Id recordId, Boolean isSuccess, List<Database.Error> errors, SObject originSObject) {
        recordId = recordId;
        isSuccess = isSuccess;
        errors = errors;
        originSObject = originSObject;
    }

    public String getErrorString() {
        final StringBuilder fullErrors = new StringBuilder();
        fullErrors.setSeparator('\n');
        for (Database.Error error : errors) {
            fullErrors.append(error.getMessage());
        }
        return fullErrors.toString();
    }

    public class InsertResult extends DatabaseResult {
        public InsertResult(Database.SaveResult saveResult, SObject originSObject) {
            super(saveResult.getId(), saveResult.isSuccess(), saveResult.getErrors(), originSObject);
        }
    }

    public class UpdateResult extends DatabaseResult {
        public UpdateResult(Database.SaveResult saveResult, SObject originSObject) {
            super(saveResult.getId(), saveResult.isSuccess(), saveResult.getErrors(), originSObject);
        }
    }

    public class UpsertResult extends DatabaseResult {
        private final Boolean isCreated;
        public UpsertResult(Database.UpsertResult upsertResult, SObject originSObject) {
            super(upsertResult.getId(), upsertResult.isSuccess(), upsertResult.getErrors(), originSObject);
            this.isCreated = upsertResult.isCreated();
        }
    }

    public class DeleteResult extends DatabaseResult {
        public DeleteResult(Database.DeleteResult deleteResult, SObject originSObject) {
            super(deleteResult.getId(), deleteResult.isSuccess(), deleteResult.getErrors(), originSObject);
        }
    }

    public class UndeleteResult extends DatabaseResult {
        public UndeleteResult(Database.UndeleteResult undeleteResult, SObject originSObject) {
            super(undeleteResult.getId(), undeleteResult.isSuccess(), undeleteResult.getErrors(), originSObject);
        }
    }
}