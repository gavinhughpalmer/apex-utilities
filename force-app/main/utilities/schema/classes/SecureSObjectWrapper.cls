/**
 * @author Gavin Palmer
 * @date 2019-03-23
 * @group Schema
 * @description This class is a secure wrapper for the sobject that obeys field level security for the user accessing it
 *
 **/
public class SecureSObjectWrapper extends SObjectWrapper {
    public SecureSObjectWrapper(SObject sObjectToWrap) {
        super(sObjectToWrap);
    }

    public override Object get(String fieldApiName) {
        DescribeFieldResult field = describe(fieldApiName);
        if (field.isAccessible()) {
            return super.get(fieldApiName);
        }
        return null;
    }

    public override void put(String fieldApiName, Object fieldValue) {
        DescribeFieldResult field = describe(fieldApiName);
        if (field.isCreateable() && field.isUpdateable()) {
            super.put(fieldApiName, fieldValue);
        }
    }
}
