/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description Test class for the AbstractSObjectTestFactory, this was to ensure the dependancies were inserting correctly 
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
private class AbstractSObjectTestFactoryTest {
    @IsTest
    private static void insertWithDependanciesTest() {
        ContactTestFactory contactFactory = new ContactTestFactory();
        Contact testContact = (Contact) contactFactory.insertWithDependancies();
        System.assertNotEquals(
            null, testContact.AccountId, 
            'The account dependancy should have been created when the contact record is inserted with dependancies'
        );
    }
}
