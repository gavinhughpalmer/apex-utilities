/**
 * @author Gavin Palmer <gavin.palmer@cloudshiftgroup.com>
 * @date 2019-06-04
 * @group CloudShiftGroup
 * @description This class can be used to build up dynamic soql queries
 *
 * Date          author             Change Description
 * -----------------------------------------------------------------------------------
 * 04/06/2019    Gavin Palmer       Created Class
 */
public virtual class QueryBuilder {
    public class QueryException extends Exception {
    }

    private static final String SOQL_QUERY_STRUCTURE = 'SELECT {0} FROM {1}';
    protected final String objectName;
    private final Set<String> fieldsToQuery = new Set<String>();
    protected final SchemaFacade schema = SchemaFacade.getInstance();
    protected final DescribeSObjectResult objectDescribe;

    protected QueryBuilder(String objectName) {
        validateObjectName(objectName);
        this.objectName = objectName;
        objectDescribe = schema.getDescribe(objectName);
    }

    public static QueryBuilder fromObject(String objectName) {
        return new QueryBuilder(objectName);
    }

    private void validateObjectName(String objectName) {
        if (schema.isNotValidSObject(objectName)) {
            throw new QueryException('The object name \'' + objectName + '\' is not valid');
        }
    }

    public QueryBuilder selectField(String field) {
        fieldsToQuery.add(field.toLowerCase());
        return this;
    }

    public QueryBuilder selectFields(List<String> fields) {
        for (String field : fields) {
            selectField(field);
        }
        return this;
    }

    public QueryBuilder selectFieldSet(String fieldSetName) {
        for (Schema.FieldSetMember member : objectDescribe.FieldSets.getMap().get(fieldSetName).getFields()) {
            selectField(member.getFieldPath());
        }
        return this;
    }

    public QueryBuilder selectAllFields() {
        for (String field : objectDescribe.fields.getMap().keySet()) {
            selectField(field);
        }
        return this;
    }

    public QueryBuilder selectAllAccessibleFields() {
        for (Schema.SObjectField field : objectDescribe.fields.getMap().values()) {
            if (field.getDescribe().isAccessible()) {
                selectField(field.getDescribe().getName());
            }
        }
        return this;
    }

    public override String toString() {
        validateFields();
        return String.format(
            SOQL_QUERY_STRUCTURE,
            new List<String>{String.join(new List<String>(fieldsToQuery), ','), objectName}
        );
    }

    private void validateFields() {
        if (fieldsToQuery.isEmpty()) {
            throw new QueryException(
                'No fields have been added into the query so it cannot be executed'
            );
        }
    }
}
