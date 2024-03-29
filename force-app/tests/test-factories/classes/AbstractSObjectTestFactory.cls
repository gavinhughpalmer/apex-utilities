/**
 * @author Gavin Palmer
 * @date 2018-10-23
 * @group Test Factory Framework
 * @description This factory class will be used as a base for any SObject creation in test classes,
 *    this pattern will define attributes that can be set in the test classes.
 *    This allows any required fields / validations to be defined in what is returned in the getSObject method
 *    allowing developers to easily enforce required fields accross all test classes if they are ever added
 *    in the UI. The method for inserting the records can be injected if specific ties around the insert need to be added for a
 *    specific use case, eg in the abstract SObject test factory test class
 *
 **/
public without sharing abstract class AbstractSObjectTestFactory {
    private final Map<String, FactoryDependancy> dependancies = new Map<String, FactoryDependancy>();
    private Insertable inserter = new DmlInserter();
    public String uniqueValue = 'test';
    private SObject recordToCreate;
    private List<SObject> recordsToCreate;

    public void setInserter(Insertable inserter) {
        this.inserter = inserter;
    }

    public abstract SObject getSObject();

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

    public virtual SObject insertSObject() {
        if (recordToCreate != null) {
            return recordToCreate;
        }
        recordToCreate = getSObject();
        return inserter.insertSObject(recordToCreate);
    }

    public virtual SObject insertWithDependancies() {
        if (recordToCreate != null) {
            return recordToCreate;
        }
        recordToCreate = getSObject();
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.parentFactory.setInserter(inserter);
            dependancy.createDependancyFor(recordToCreate);
        }
        return inserter.insertSObject(recordToCreate);
    }

    public virtual List<SObject> insertMultipleSObjects(Integer numberToInsert) {
        if (recordsToCreate != null) {
            return recordsToCreate;
        }
        recordsToCreate = getMultipleSObjects(numberToInsert);
        return inserter.insertMultipleSObject(recordsToCreate);
    }

    public virtual List<SObject> insertMultipleWithDependancies(Integer numberToInsert) {
        if (recordsToCreate != null) {
            return recordsToCreate;
        }
        recordsToCreate = getMultipleSObjects(numberToInsert);
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.parentFactory.setInserter(inserter);
            dependancy.createDependanciesFor(recordsToCreate);
        }
        return inserter.insertMultipleSObject(recordsToCreate);
    }

    /*
     * @desription This method should be called in the constructor which will define the dependancies for this SObject
     * eg account for the contact
     */
    public void addDependancy(String parentIdField, Type parentFactoryType) {
        dependancies.put(parentIdField, new FactoryDependancy(parentIdField, parentFactoryType));
    }

    private class FactoryDependancy {
        private final Relationship parentRelationship;
        private final Type parentFactoryType;
        private final AbstractSObjectTestFactory parentFactory;

        public FactoryDependancy(String parentIdField, Type parentFactoryType) {
            this.parentFactory = (AbstractSObjectTestFactory) parentFactoryType.newInstance();
            // this.parentFactory = parentFactory;
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
                childSObjects[i]
                    .putSObject(parentRelationship.referenceFieldName, parentSObjects[i]);
            }
        }
    }
}
