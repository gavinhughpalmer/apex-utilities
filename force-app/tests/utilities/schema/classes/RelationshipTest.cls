/**
 * @author Gavin Palmer
 * @date 2020-05-29
 *
 **/
@IsTest(isParallel=true)
private class RelationshipTest {
    @IsTest
    private static void fromRefrenceFieldStandardField() {
        Relationship accountLookup = Relationship.fromRefrenceField('Account');
        Assert.areEqual(
            'AccountId',
            accountLookup.idFieldName,
            'The relationship field has not assigned the id field correctly'
        );
    }

    @IsTest
    private static void fromIdFieldStandardField() {
        Relationship accountLookup = Relationship.fromIdField('AccountId');
        Assert.areEqual(
            'Account',
            accountLookup.referenceFieldName,
            'The id field has not assigned the relationship field correctly'
        );
    }

    @IsTest
    private static void fromRefrenceFieldCustomField() {
        Relationship accountLookup = Relationship.fromRefrenceField('Account__r');
        Assert.areEqual(
            'Account__c',
            accountLookup.idFieldName,
            'The relationship field has not assigned the id field correctly'
        );
    }

    @IsTest
    private static void fromIdFieldCustomField() {
        Relationship accountLookup = Relationship.fromIdField('Account__c');
        Assert.areEqual(
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
            Assert.isTrue(
                exceptionToCheck.getMessage().contains(Relationship.INVALID_RELATIONSHIP_FIELD),
                'The string (' +
                Relationship.INVALID_RELATIONSHIP_FIELD +
                ') was not found in the string: ' +
                exceptionToCheck.getMessage()
            );
        } catch (Exception invalidException) {
            Assert.fail(
                'The exception thown was not what was expected, message: ' + invalidException
            );
        }
    }
}
