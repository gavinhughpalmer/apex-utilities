/*
* This factory class will be used as a base for any SObject creation in test classes,
* this pattern will define attributes that can be set in the test classes.
* This allows any required fields / validations to be defined in what is returned in the getSObject method
* allowing developers to easily enforce required fields accross all test classes if they are ever added
* in the UI
*/
public without sharing abstract class AbstractSObjectTestFactory {

    public String uniqueValue = 'test';

    public abstract SObject getSObject();

    public SObject insertSObject() {
        SObject sObjectToInsert = getSObject();
        insert sObjectToInsert;
        return sObjectToInsert;
    }

    public virtual List<SObject> getMultipleSObjects(Integer numberToCreate) {
        List<SObject> sObjectsToReturn = new List<SObject>();
        final String uniqueValuePrefix = uniqueValue;
        for (Integer i = 0; i < numberToCreate; i++) {
            uniqueValue = uniqueValuePrefix + i;
            sObjectsToReturn.add(getSObject());
        }
        uniqueValue = uniqueValuePrefix;
        return sObjectsToReturn;
    }

    public List<SObject> insertMultipleSObjects(Integer numberToInsert) {
        List<SObject> sObjectsToInsert = getMultipleSObjects(numberToInsert);
        insert sObjectsToInsert;
        return sObjectsToInsert;
    }
}
