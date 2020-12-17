/**
 * @author Gavin Palmer
 * @date 2018-06-28
 * @group Trigger Framework
 * @description This interface will be implemented by any action that is used in a trigger,
 * this allows each trigger to loop over the set of records once to complete all the actions in the system.
 * intention is that any initial setup actions can be performed in the constructor (ie set up some required data),
 * then the register will determine if the new record should have any actions performed and add to a private list,
 * then finally the performAction will run any dml / soql, essentially the bulk of the logic
 *
 **/
public abstract class Triggerable {
    /*
     * @description Within the trigger framework, this method will get called once (and only once) for every record entering the trigger.
     * This should be used to build up a list of records that wish to be operated on, or in the case of validation it can run the validation directly.
     */
    public abstract void register(SObjectTriggerWrapper wrappedSObject);

    /*
     * @description this method will be called once for every trigger action,
     * that is after all the records have been iterated over. The use case is for performing any of the
     * DML or SOQL that is required.
     */
    @SuppressWarnings('PMD.EmptyStatementBlock')
    public virtual void performAction() {
        // This allows us to have not implement if not nessisary on extention classes, as without this there were a lot of validation like classes that would have an empty code block
    }
}
