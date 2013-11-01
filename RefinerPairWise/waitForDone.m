function isDone = waitForDone(object,timeout)
    % Initialize: timeout flag = false
    object.setDone(false);
 
    % Create and start the separate timeout timer thread
    hTimer = timer('TimerFcn',@(h,e)object.setDone(true), 'StartDelay',timeout);
    start(hTimer);
 
    % Wait for the object property to change or for timeout, whichever comes first
    waitfor(object,'Done',true);
 
    % waitfor is over - either because of timeout or because the data changed
    % To determine which, check whether the timer callback was activated
    isDone = (hTimer.TasksExecuted == 0);
 
    % Delete the time object
    try stop(hTimer);   catch, end
    try delete(hTimer); catch, end
 
    % Return the flag indicating whether or not timeout was reached
end  % waitForDone