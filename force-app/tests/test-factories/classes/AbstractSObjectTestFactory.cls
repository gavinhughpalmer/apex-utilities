/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This factory class will be used as a base for any SObject creation in test classes,
*    this pattern will define attributes that can be set in the test classes.
*    This allows any required fields / validations to be defined in what is returned in the getSObject method
*    allowing developers to easily enforce required fields accross all test classes if they are ever added
*    in the UI. The method for inserting the records can be injected if specific ties around the insert need to be added for a
*    specific use case, eg in the abstract SObject test factory test class
*
* 2018-10-23 : Gavin Palmer - Original
**/
public without sharing abstract class AbstractSObjectTestFactory {

    private final Map<String, FactoryDependancy> dependancies = new Map<String, FactoryDependancy>();
    private Insertable inserter = new DmlInserter();
    public String uniqueValue = 'test';

    public void setInserter(Insertable inserter) {
        this.inserter = inserter;
    }

    public abstract SObject getSObject();

    public virtual SObject insertSObject() {
        SObject sObjectToInsert = getSObject();
        return inserter.insertSObject(sObjectToInsert);
    }

    // TODO will need to implement some form of caching for objects that have multiple lookups to the same objects
    public virtual SObject insertWithDependancies() {
        SObject sObjectToInsert = getSObject();
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.createDependancyFor(sObjectToInsert);
        }
        return inserter.insertSObject(sObjectToInsert);
    }

    public virtual List<SObject> insertMultipleWithDependancies(Integer numberToInsert) {
        List<SObject> sObjectsToInsert = getMultipleSObjects(numberToInsert);
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.createDependanciesFor(sObjectsToInsert);
        }
        return inserter.insertMultipleSObject(sObjectsToInsert);
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

    public virtual List<SObject> insertMultipleSObjects(Integer numberToInsert) {
        List<SObject> sObjectsToInsert = getMultipleSObjects(numberToInsert);
        return inserter.insertMultipleSObject(sObjectsToInsert);
    }

    public void addDependancy(String parentIdField, AbstractSObjectTestFactory parentFactory) {
        dependancies.put(parentIdField, new FactoryDependancy(parentIdField, parentFactory));
    }

    private class FactoryDependancy {
        private final Relationship parentRelationship;
        private final AbstractSObjectTestFactory parentFactory;

        public FactoryDependancy(String parentIdField, AbstractSObjectTestFactory parentFactory) {
            this.parentFactory = parentFactory;
            parentRelationship = Relationship.fromIdField(parentIdField);
        }
        public void createDependancyFor(SObject childSObject) {
            SObject parentSObject = parentFactory.insertWithDependancies();
            childSObject.put(parentRelationship.idFieldName, parentSObject.Id);
            childSObject.putSObject(parentRelationship.referenceFieldName, parentSObject);
        }
        public void createDependanciesFor(List<SObject> childSObjects) {
            final Integer total = childSObjects.size();
            List<SObject> parentSObjects = parentFactory.insertMultipleWithDependancies(total);
            for (Integer i = 0; i < total; i++) {
                childSObjects[i].put(parentRelationship.idFieldName, parentSObjects[i].Id);
                childSObjects[i].putSObject(parentRelationship.referenceFieldName, parentSObjects[i]);
            }
        }
    }

    public interface Insertable {
        SObject insertSObject(SObject sObjectToInsert);
        List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert);
    }

    private class DmlInserter implements Insertable {
        public SObject insertSObject(SObject sObjectToInsert) {
            insert sObjectToInsert;
        }

        public List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert) {
            insert sObjectsToInsert;
        }
    }
}
