public with sharing class TestFactory {

    private static final Map<Type, AbstractSObjectTestFactory> TEST_FACTORIES = new Map<Type, AbstractSObjectTestFactory>();

    public static AbstractSObjectTestFactory getTestFactory(Type factoryClass) {
        AbstractSObjectTestFactory testFactory = (AbstractSObjectTestFactory) factoryClass.newInstance();
        
    }
}
