/**
 * @author Gavin Palmer
 * @description Utility class to help make interacting with an objects record types slightly easier eg cal call
 * SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
 * Id defaultOpportunityRecordTypeId = opportunityRecordTypes.getDefaultId();
 *
 * @date 2019-09-24
 * 2020-09-22 : Khin Hou - adding option to get a record type developer name from an Id
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

    public Id getRecordTypeId(final String developerName) {
        Id recordTypeId;
        if (recordTypesByDeveloperName.containsKey(developerName)) {
            recordTypeId = recordTypesByDeveloperName.get(developerName).getRecordTypeId();
        }
        return recordTypeId;
    }

    public String getRecordTypeDeveloperName(final Id recordTypeId) {
        String recordTypeDeveloperName;
        if (recordTypesById.containsKey(recordTypeId)) {
            recordTypeDeveloperName = recordTypesById.get(recordTypeId).getDeveloperName();
        }
        return recordTypeDeveloperName;
    }
}
