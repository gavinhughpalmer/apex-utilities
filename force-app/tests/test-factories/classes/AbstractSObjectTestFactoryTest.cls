/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description Test class for the AbstractSObjectTestFactory, this was to ensure the dependancies were inserting correctly
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
private class AbstractSObjectTestFactoryTest {
    @IsTest
    private static void insertWithDependanciesTest() {
        MockContactTestFactory contactFactory = new MockContactTestFactory();
        contactFactory.setInserter(new MockInserter());
        Contact testContact = (Contact) contactFactory.insertWithDependancies();
        System.assertNotEquals(
            null, testContact.Account.Name,
            'The account dependancy should have been created when the contact record is inserted with dependancies'
        );
    }

    // Create our own test factories to test the dependancy creation process in the abstract test factory
    public class MockAccountTestFactory extends AbstractSObjectTestFactory {
        public String name = 'My account name';
        public override SObject getSObject() {
            return new Account(
                Name = name
            );
        }
    }
    public class MockContactTestFactory extends AbstractSObjectTestFactory {
        public String lastName = 'TestUser';
        public MockContactTestFactory() {
            addDependancy('AccountId', new AccountTestFactory());
        }
        public override SObject getSObject() {
            return new Contact(
                LastName = lastName
            );
        }
    }

    private class MockInserter implements AbstractSObjectTestFactory.Insertable {
        @SuppressWarnings('PMD.EmptyStatementBlock')
        public SObject insertSObject(SObject sObjectToInsert) {
            // Do nothing
        }
        @SuppressWarnings('PMD.EmptyStatementBlock')
        public List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert) {
            // Do nothing
        }
    }
}
