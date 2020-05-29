/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This factory class will be used as a base for any SObject creation in test classes,
*    this pattern will define attributes that can be set in the test classes.
*    This allows any required fields / validations to be defined in what is returned in the getSObject method
*    allowing developers to easily enforce required fields accross all test classes if they are ever added
*    in the UI
*
* 2018-10-23 : Gavin Palmer - Original
**/
public without sharing abstract class AbstractSObjectTestFactory {

    protected final List<FactoryDependancy> dependancies = new List<FactoryDependancy>();
    public String uniqueValue = 'test';

    public abstract SObject getSObject();
    @SuppressWarnings('PMD.EmptyStatementBlock')
    public virtual void initialiseDependancies() {
        // do nothing by default, so all subclasses do not have to implement
    }

    public virtual SObject insertSObject() {
        SObject sObjectToInsert = getSObject();
        insert sObjectToInsert;
        return sObjectToInsert;
    }

    // TODO will need to implement some form of caching for objects that have multiple lookups to the same objects
    public virtual SObject insertWithDependancies() {
        initialiseDependancies();
        SObject sObjectToInsert = getSObject();
        for (FactoryDependancy dependancy : dependancies) {
            dependancy.createDependancyFor(sObjectToInsert);
        }
        insert sObjectToInsert;
        return sObjectToInsert;
    }

    public virtual List<SObject> insertMultipleWithDependancies(Integer numberToInsert) {
        initialiseDependancies();
        List<SObject> sObjectsToInsert = getMultipleSObjects(numberToInsert);
        for (FactoryDependancy dependancy : dependancies) {
            dependancy.createDependanciesFor(sObjectsToInsert);
        }
        insert sObjectsToInsert;
        return sObjectsToInsert;
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
        insert sObjectsToInsert;
        return sObjectsToInsert;
    }

    public class FactoryDependancy {
        private final AbstractSObjectTestFactory parentFactory;
        private final Relationship parentRelationship;

        public FactoryDependancy(AbstractSObjectTestFactory parentFactory, String parentIdField) {
            this.parentFactory = parentFactory;
            parentRelationship = Relationship.fromIdField(parentIdField);
        }
        public void createDependancyFor(SObject childSObject) {
            SObject parentSObject = parentFactory.insertWithDependancies();
            childSObject.put(parentRelationship.idFieldName, parentSObject.Id);
            childSObject.putSObject(parentRelationship.refrenceFieldName, parentSObject);
        }
        public void createDependanciesFor(List<SObject> childSObjects) {
            final Integer total = childSObjects.size();
            List<SObject> parentSObjects = parentFactory.insertMultipleWithDependancies(total);
            for (Integer i = 0; i < total; i++) {
                childSObjects[i].put(parentRelationship.idFieldName, parentSObjects[i].Id);
                childSObjects[i].putSObject(parentRelationship.refrenceFieldName, parentSObjects[i]);
            }
        }
    }
}
