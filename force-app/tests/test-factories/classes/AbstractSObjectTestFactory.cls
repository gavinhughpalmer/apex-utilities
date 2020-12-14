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

    public void allowDuplicatesOnSave(Boolean areRulesOn) {
        inserter.allowDuplicatesOnSave(areRulesOn);
    }

    public abstract SObject getSObject();

    public virtual SObject insertSObject() {
        recordToCreate = getSObject();
        return inserter.insertSObject(recordToCreate);
    }

    public virtual SObject insertWithDependancies() {
        recordToCreate = getSObject();
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.parentFactory.setInserter(inserter);
            dependancy.createDependancyFor(recordToCreate);
        }
        return inserter.insertSObject(recordToCreate);
    }

    public virtual List<SObject> insertMultipleWithDependancies(Integer numberToInsert) {
        recordsToCreate = getMultipleSObjects(numberToInsert);
        for (FactoryDependancy dependancy : dependancies.values()) {
            dependancy.parentFactory.setInserter(inserter);
            dependancy.createDependanciesFor(recordsToCreate);
        }
        return inserter.insertMultipleSObject(recordsToCreate);
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
        recordsToCreate = getMultipleSObjects(numberToInsert);
        return inserter.insertMultipleSObject(recordsToCreate);
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
                childSObjects[i]
                    .putSObject(parentRelationship.referenceFieldName, parentSObjects[i]);
            }
        }
    }
}