/**
 * @author Gavin Palmer <gavinhughpalmer@gmail.com>
 * @date 2019-06-04
 * @group CloudShiftGroup
 *
 * Date          author             Change Description
 * -----------------------------------------------------------------------------------
 * 04/06/2019    Gavin Palmer       Created Class
 */
@IsTest(isParallel=true)
private class QueryBuilderTest {
    @IsTest
    private static void buildQueryTest() {
        QueryBuilder accountQuery = QueryBuilder.fromObject('Account').selectField('Id');

        System.assertEquals(
            'select id from account',
            accountQuery.toString().toLowerCase(),
            'The query has not been generated correctly'
        );
    }
}
