/**
 * @author Gavin Palmer
 * @date 2019-06-04
 *
 */
@IsTest(isParallel=true)
private class QueryBuilderTest {
    @IsTest
    private static void buildQueryTest() {
        QueryBuilder accountQuery = QueryBuilder.fromObject('Account').selectField('Id');

        Assert.areEqual(
            'select id from account',
            accountQuery.toString().toLowerCase(),
            'The query has not been generated correctly'
        );
    }
}
