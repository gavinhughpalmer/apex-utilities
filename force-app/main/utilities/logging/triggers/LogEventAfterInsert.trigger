/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2019-04-20 : Gavin Palmer - Original
**/
trigger LogEventAfterInsert on Log_Event__e (after insert) {
    TriggerDispatcher.run(
        new List<Triggerable>{
            new LogWriter()
        }
    );
}