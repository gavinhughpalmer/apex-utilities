/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class will hold the picklist values of an object so that the values can be more easily retrieved
 *
 * 2020-02-11 : Gavin Palmer - Original
 **/
public class PicklistValueSet {

    private final Map<String, String> apiNameByValues = new Map<String, String>();
    private final Map<String, String> valuesByApiNames = new Map<String, String>();
    private final DescribeFieldResult fieldDefinition;

    public PicklistValueSet(DescribeFieldResult fieldDefinition) {
        this.fieldDefinition = fieldDefinition;
        for (Schema.PicklistEntry value : fieldDefinition.getPickListValues()) {
            apiNameByValues.put(value.getValue().toLowerCase(), value.getLabel());
            valuesByApiNames.put(value.getLabel().toLowerCase(), value.getValue());
        }
    }

    public String getValue(String label) {
        return valuesByApiNames.get(label.toLowerCase());
    }

    public String getLabel(String value) {
        return apiNameByValues.get(value.toLowerCase());
    }
}