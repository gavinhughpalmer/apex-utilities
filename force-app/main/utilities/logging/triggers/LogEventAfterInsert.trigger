/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2019-04-20
 **/
trigger LogEventAfterInsert on Log_Event__e(after insert) {
    TriggerDispatcher.run(new List<Triggerable>{ new LogWriter() });
}
