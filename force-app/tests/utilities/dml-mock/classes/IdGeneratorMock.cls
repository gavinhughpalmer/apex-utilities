/**
 * @author Khin Hou
 * @date 2020-11-05
 * @group DML Mock
 * @description Class to generated Ids for test mocking
 *
 **/
public with sharing class IdGeneratorMock {
    private String idPrefix;
    private Integer idIterator = 0;
    @SuppressWarnings('PMD.AvoidHardcodingId')
    private static final String ID_CONSTANT = '000000000000000';

    public IdGeneratorMock(Schema.SObjectType sObjectType) {
        idPrefix = getPrefixOfId(sObjectType);
    }

    @TestVisible
    private String getPrefixOfId(Schema.SObjectType sObjectType) {
        String prefix;

        try {
            prefix = sObjectType.getDescribe(SObjectDescribeOptions.DEFERRED).getKeyPrefix();
        } catch (Exception exceptionToHandle) {
            throw new IdGeneratorMockException('Cannot resolve prefix for SObject,' + sObjectType);
        }

        return prefix;
    }

    public Id getNextAvailableId() {
        idIterator++;
        String idIteratorString = String.valueOf(idIterator);
        String generatedId = idPrefix + ID_CONSTANT;
        generatedId = generatedId.left(generatedId.length() - idIteratorString.length());
        generatedId = generatedId + idIteratorString;
        return (Id) generatedId;
    }

    private class IdGeneratorMockException extends Exception {
    }
}
