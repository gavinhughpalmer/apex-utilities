/**
 * @author Gavin Palmer
 * @date 2018-10-23
 * @group Test Factory Framework
 * @description Test class for the AbstractSObjectTestFactory, this was to ensure the dependancies were inserting correctly
 *
 **/
@IsTest
private class AbstractSObjectTestFactoryTest {
    @IsTest
    private static void insertWithDependanciesTest() {
        MockContactTestFactory contactFactory = new MockContactTestFactory();
        Insertable inserter = new MockInserter();
        inserter.allowDuplicatesOnSave(false);
        contactFactory.setInserter(inserter);
        Contact testContact = (Contact) contactFactory.insertWithDependancies();
        System.assertNotEquals(
            null,
            testContact.Account.Name,
            'The account dependancy should have been created when the contact record is inserted with dependancies'
        );
    }

    @IsTest
    private static void insertMultipleWithDependanciesTest() {
        MockContactTestFactory contactFactory = new MockContactTestFactory();
        Insertable inserter = new MockInserter();
        inserter.allowDuplicatesOnSave(true);
        contactFactory.setInserter(inserter);
        List<Contact> testContacts = (List<Contact>) contactFactory.insertMultipleWithDependancies(
            50
        );

        System.assertNotEquals(
            true,
            testContacts.isEmpty(),
            'Multiple contacts should have been created'
        );

        for (Contact contact : testContacts) {
            System.assertNotEquals(
                null,
                contact.Account.Name,
                'The account dependancy should have been created when the contact record is inserted with dependancies'
            );
        }
    }

    // Create our own test factories to test the dependancy creation process in the abstract test factory
    public class MockAccountTestFactory extends AbstractSObjectTestFactory {
        public String name = 'My account name';
        public override SObject getSObject() {
            return new Account(Name = name);
        }
    }
    public class MockContactTestFactory extends AbstractSObjectTestFactory {
        public String lastName = 'TestUser';
        public MockContactTestFactory() {
            addDependancy('AccountId', MockAccountTestFactory.class);
        }
        public override SObject getSObject() {
            return new Contact(LastName = lastName);
        }
    }
    private class MockInserter implements Insertable {
        Boolean allowDuplicatesOnSave = false;
        public Boolean allowDuplicatesOnSave(Boolean areRulesOn) {
            allowDuplicatesOnSave = areRulesOn;
            return allowDuplicatesOnSave;
        }
        public SObject insertSObject(SObject sObjectToInsert) {
            // do nothing...
            return sObjectToInsert;
        }
        public List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert) {
            // do nothing...
            return sObjectsToInsert;
        }
    }
}
