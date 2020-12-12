/**
 * @author Gavin Palmer
 *
 * @date 2020-05-29
 **/
@IsTest(isParallel=true)
private class RelationshipTest {
    @IsTest
    private static void fromRefrenceFieldStandardField() {
        Relationship accountLookup = Relationship.fromRefrenceField('Account');
        System.assertEquals(
            'AccountId',
            accountLookup.idFieldName,
            'The relationship field has not assigned the id field correctly'
        );
    }

    @IsTest
    private static void fromIdFieldStandardField() {
        Relationship accountLookup = Relationship.fromIdField('AccountId');
        System.assertEquals(
            'Account',
            accountLookup.referenceFieldName,
            'The id field has not assigned the relationship field correctly'
        );
    }

    @IsTest
    private static void fromRefrenceFieldCustomField() {
        Relationship accountLookup = Relationship.fromRefrenceField('Account__r');
        System.assertEquals(
            'Account__c',
            accountLookup.idFieldName,
            'The relationship field has not assigned the id field correctly'
        );
    }

    @IsTest
    private static void fromIdFieldCustomField() {
        Relationship accountLookup = Relationship.fromIdField('Account__c');
        System.assertEquals(
            'Account__r',
            accountLookup.referenceFieldName,
            'The id field has not assigned the relationship field correctly'
        );
    }

    @IsTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    private static void fromIdFieldInvalidCustomField() {
        try {
            Relationship.fromIdField('Account__p');
            Assert.fail(
                'An excpetion should be thrown when an invalid field is passed into the relationship constructor'
            );
        } catch (InvalidFieldException exceptionToCheck) {
            Assert.contains(exceptionToCheck.getMessage(), Relationship.INVALID_RELATIONSHIP_FIELD);
        } catch (Exception invalidException) {
            Assert.fail(
                'The exception thown was not what was expected, message: ' + invalidException
            );
        }
    }
}
