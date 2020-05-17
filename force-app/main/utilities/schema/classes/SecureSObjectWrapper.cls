/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This class is a secure wrapper for the sobject that obeys field level security for the user accessing it
*
* 2019-03-23 : Gavin Palmer - Original
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
