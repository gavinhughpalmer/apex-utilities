// Could include some of the error handling that is normally used in database methods, eg adding an error to the input record, potentially with some way of extending and adding additional error handling for specific use cases
// Log on error as some kind of parameter or method so that if the calling class just wants to log the error no boilerplate code needs to be written
// get success vs get failure methods so these can be operated on seperately
public inherited sharing class DatabaseWrapper {

    public static DatabaseResult save(SObject sObjectToSave) {
        if (String.isBlank(sObjectToSave.Id)) {
            return insertRecord(sObjectToSave);
        } else {
            return updateRecord(sObjectToSave);
        }
    }

    public static InsertResult insertRecord(SObject sObjectToInsert) {
        return new InsertResult(Database.insert(sObjectToInsert, false), sObjectToInsert);
    }

    public static UpdateResult updateRecord(SObject sObjectToUpdate) {
        return new UpdateResult(Database.update(sObjectToUpdate, false), sObjectToUpdate);
    }

    public static UpsertResult upsertRecord(SObject sObjectToUpsert) {
        return new UpsertResult(Database.upsert(sObjectToUpsert, false), sObjectToUpsert);
    }

    public static DeleteResult deleteRecord(SObject sObjectToDelete) {
        return new DeleteResult(Database.delete(sObjectToDelete, false), sObjectToDelete);
    }

    public static UndeleteResult undeleteRecord(SObject sObjectToUndelete) {
        return new UndeleteResult(Database.undelete(sObjectToUndelete, false), sObjectToUndelete);
    }

    public static EmptyRecycleBinResult emptyRecycleBin(SObject sObjectToHardDelete) {
        return new EmptyRecycleBinResult(Database.emptyRecycleBin(sObjectToHardDelete, false), sObjectToHardDelete);
    }

    public static DatabaseResult hardDelete(SObject sObjectToHardDelete) {
        DatabaseResult results = deleteRecord(sObjectToHardDelete);
        if (results.isSuccess()) {
            return new EmptyRecycleBinResult(Database.emptyRecycleBin(sObjectToHardDelete, false), sObjectToHardDelete);
        }
        return results;
    }

    public static ConvertLeadResult convertLeadRecord(SObject sObjectToConvertLead) {
        return new ConvertLeadResult(Database.convertLead(sObjectToConvertLead, false), sObjectToConvertLead);
    }

    public static MergeResult mergeRecord(SObject sObjectToMerge, List<SObject> duplicates) {
        return new MergeResult(Database.merge(sObjectToMerge, duplicates, false), sObjectToMerge);
    }

    public class DatabaseResults {
        private final List<DatabaseResult> results;
        private final List<SObject> sourceSObjects;

        public DatabaseResults(List<DatabaseResult> results, List<SObject> sourceSObjects) {
            this.results = results;
            this.sourceSObjects = sourceSObjects;
        }
    }

    public abstract class DatabaseResult {
        private final Id recordId;
        private final Boolean isSuccess;
        private final List<Database.Error> errors;
        private final SObject originSObject;


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
        public UpdateResult(Database.UpsertResult upsertResult, SObject originSObject) {
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

    public class EmptyRecycleBinResult extends DatabaseResult {
        public EmptyRecycleBinResult(Database.EmptyRecycleBinResult emptyRecycleBinResult, SObject originSObject) {
            super(emptyRecycleBinResult.getId(), emptyRecycleBinResult.isSuccess(), emptyRecycleBinResult.getErrors(), originSObject);
        }
    }

    public class MergeResult extends DatabaseResult {
        private final List<String> mergedRecordIds;
        private final List<String> updatedRelatedIds;
        private final List<SObject> duplicates;
        public MergeResult(Database.MergeResult mergeResult, SObject originSObject, List<SObject> duplicates) {
            super(mergeResult.getId(), mergeResult.isSuccess(), mergeResult.getErrors(), originSObject);
            mergedRecordIds = mergeResult.getMergedRecordIds();
            updatedRelatedIds = mergeResult.getUpdatedRelatedIds();
            this.duplicates = duplicates;
        }
    }

    public class LeadConvertResult extends DatabaseResult {
        private final Id accountId;
        private final Id contactId;
        private final Id opportunityId;

        public LeadConvertResult(Database.LeadConvertResult leadConvertResult, SObject originSObject) {
            // The lead id is used in place of the id here as in all other instances it is the input record, so this seems to make logical sense
            super(leadConvertResult.getLeadId(), leadConvertResult.isSuccess(), leadConvertResult.getErrors(), originSObject);
            accountId = leadConvertResultgetAccountId();
            contactId = leadConvertResultgetContactId();
            opportunityId = leadConvertResultgetOpportunityId();
        }
    }
}