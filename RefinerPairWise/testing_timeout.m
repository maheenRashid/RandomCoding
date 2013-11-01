ccc

%  start = clock;
 timeout = 10; %secs
 
 while(true)
 waitForDone(@dummy_fcn,timeout);
disp(waitForReturned)
 dummy_fcn();
 
%  if(etime(clock,start)==TimeOut)
%  return
%  end
 
 end
 