/**
 * @author Gavin Palmer
 * @date 2019-09-24
 * @group Schema
 * @description Utility class to help make interacting with an objects record types slightly easier eg cal call
 * SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
 * Id defaultOpportunityRecordTypeId = opportunityRecordTypes.getDefaultId();
 *
 **/
public inherited sharing class SObjectRecordTypes {
    private final Map<String, Schema.RecordTypeInfo> recordTypesByDeveloperName;
    private final Map<Id, Schema.RecordTypeInfo> recordTypesById;
    private RecordTypeInfo defaultRecordTypeInfo;

    public SObjectRecordTypes(final String objectApiName) {
        final SchemaFacade schema = SchemaFacade.getInstance();
        final DescribeSObjectResult objectDescribe = schema.getDescribe(objectApiName);
        recordTypesByDeveloperName = objectDescribe.getRecordTypeInfosByDeveloperName();
        recordTypesById = objectDescribe.getRecordTypeInfosById();
    }

    /*
     * @description retrieves the default record type id for the object specified
     */
    public Id getDefaultId() {
        if (defaultRecordTypeInfo == null) {
            for (Schema.RecordTypeInfo info : recordTypesByDeveloperName.values()) {
                if (info.isDefaultRecordTypeMapping()) {
                    defaultRecordTypeInfo = info;
                    break;
                }
            }
        }
        return defaultRecordTypeInfo.getRecordTypeId();
    }

    /*
     * @description gets the record type id for the developer name specified
     */
    public Id getRecordTypeId(final String developerName) {
        Id recordTypeId;
        if (recordTypesByDeveloperName.containsKey(developerName)) {
            recordTypeId = recordTypesByDeveloperName.get(developerName).getRecordTypeId();
        }
        return recordTypeId;
    }

    /*
     * @description gets the developername for the record type id specified
     */
    public String getRecordTypeDeveloperName(final Id recordTypeId) {
        String recordTypeDeveloperName;
        if (recordTypesById.containsKey(recordTypeId)) {
            recordTypeDeveloperName = recordTypesById.get(recordTypeId).getDeveloperName();
        }
        return recordTypeDeveloperName;
    }
}
