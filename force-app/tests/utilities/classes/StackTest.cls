/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2020-11-20 : Gavin Palmer - Original
 **/
@IsTest(isParallel=true)
private class StackTest {
    @IsTest
    private static void pushPopTest() {
        final String firstItem = 'First Item';
        final String secondItem = 'Second Item';
        Stack stack = new Stack();
        System.assert(stack.isEmpty(), 'The stack should be empty before anything is added to it');

        stack.push(firstItem);

        System.assert(
            !stack.isEmpty(),
            'The stack should no longer be empty after an item is pushed onto it'
        );
        System.assertEquals(1, stack.size(), 'There should be one item on the stack');

        stack.push(secondItem);
        System.assertEquals(2, stack.size(), 'There should be 2 items on the stack');

        String firstPopped = (String) stack.pop();
        System.assertEquals(
            secondItem,
            firstPopped,
            'The second item added to the stack should be popped off first'
        );

        String secondPopped = (String) stack.pop();
        System.assertEquals(
            firstItem,
            secondPopped,
            'The first item added to the stack should be popped off last'
        );
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @IsTest
    private static void popEmptyStackExcpetion() {
        Stack stack = new Stack();
        try {
            stack.pop();
            Assert.fail('An exception should have been thrown');
        } catch (Stack.UnderflowException expectedException) {
            //NOPMD
            // just check it runs as there is no message added so nothing to assert on
        } catch (Exception unexpectedException) {
            Assert.fail(
                'An unexpected exception has been thrown with error message: ' +
                unexpectedException.getMessage()
            );
        }
    }

    @IsTest
    private static void toStringTest() {
        Stack stack = new Stack();
        stack.push('1');
        stack.push('2');
        System.assertEquals(
            '1\n2',
            stack.toString(),
            'The stack should be joined together in the toString method'
        );
    }

    @IsTest
    private static void bulkPushPopTest() {
        final Integer bulkAmount = 1000;
        List<Integer> reversedValues = new List<Integer>(bulkAmount);

        Stack stack = new Stack();
        for (Integer i = 0; i < bulkAmount; i++) {
            stack.push(i);
            reversedValues[(bulkAmount - i - 1)] = i;
        }
        for (Integer expectedValue : reversedValues) {
            System.assertEquals(
                expectedValue,
                (Integer) stack.pop(),
                'The popped value should be the last value added to the list'
            );
        }
    }
}
