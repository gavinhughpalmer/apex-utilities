/**
 * @author Gavin Palmer <gavin.palmer@cloudshiftgroup.com>
 * @date 2019-06-04
 * @group CloudShiftGroup
 * @description This inherits from the QueryBuilder but adds the functionality of populating with the field set API names
 *
 * Date          author             Change Description
 * -----------------------------------------------------------------------------------
 * 04/06/2019    Gavin Palmer       Created Class
 */
public class FieldSetQueryBuilder extends QueryBuilder {
    public FieldSetQueryBuilder(String objectName, String fieldSetName) {
        super(objectName);
        addFieldSetFields(fieldSetName);
    }

    private void addFieldSetFields(String fieldSetName) {
        Schema.DescribeSObjectResult describeSObjectResultObj = schema.getDescribe(objectName);
        Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        for (Schema.FieldSetMember member : fieldSetObj.getFields()) {
            field(member.getFieldPath());
        }
    }
}
