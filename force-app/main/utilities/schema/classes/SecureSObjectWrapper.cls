/**
 * @author Gavin Palmer
 * @date 2019-03-23
 * @group Schema
 * @description This class is a secure wrapper for the sobject that obeys field level security
 * for the user accessing it. This wraps <<SObjectWrapper>> so the recursive retrieves will be enabled
 *
 **/
public class SecureSObjectWrapper extends SObjectWrapper {
    public SecureSObjectWrapper(SObject sObjectToWrap) {
        super(sObjectToWrap);
    }

    /*
     * @description get will retrieve the field if it is visible to the user, otherwise it will return null
     */
    public override Object get(String fieldApiName) {
        DescribeFieldResult field = describe(fieldApiName);
        if (field.isAccessible()) {
            return super.get(fieldApiName);
        }
        return null;
    }

    /*
     * @description the put will only allow writing if the field is createable and updateable by the user
     */
    public override void put(String fieldApiName, Object fieldValue) {
        DescribeFieldResult field = describe(fieldApiName);
        if (field.isCreateable() && field.isUpdateable()) {
            super.put(fieldApiName, fieldValue);
        }
    }
}
