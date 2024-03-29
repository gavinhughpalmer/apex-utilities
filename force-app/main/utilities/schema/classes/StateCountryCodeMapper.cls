/**
 * @author Gavin Palmer
 * @date 2020-02-11
 * @group Schema
 * @description This class is used to get around a salesforce bug where the state/country field is not updated in a trigger, rather the state code is.
 * Other code in the org has been written to rely on the state/country field rather than the code
 *
 **/
public with sharing class StateCountryCodeMapper extends Triggerable {
    @SuppressWarnings('PMD.EagerlyLoadedDescribeSObjectResult')
    private final PicklistValueSet stateValueSet = new PicklistValueSet(
        Account.BillingStateCode.getDescribe()
    );
    @SuppressWarnings('PMD.EagerlyLoadedDescribeSObjectResult')
    private final PicklistValueSet countryValueSet = new PicklistValueSet(
        Account.BillingCountryCode.getDescribe()
    );

    public override void register(SObjectTriggerWrapper wrappedSObject) {
        Account accountRecord = (Account) wrappedSObject.getSObject();
        accountRecord.BillingState = stateValueSet.getLabel(accountRecord.BillingStateCode);
        accountRecord.BillingCountry = countryValueSet.getLabel(accountRecord.BillingCountryCode);
    }
}
