function ParforProgressStressTest2(N)
% Stress test for 'ParforProgressStarter2'. In case of timeouts, you can
% use this function to determine how many simultaneous connections your
% computer can handle, and adjust the ppm.increment() call accordingly.
%
% Copyright (c) 2010-2012, Andreas Kotowicz
%
%%
    if nargin < 1
        N = 10000;
    end
    
    this = tic();
    
    do_debug = 1;
    ppm = ParforProgressStarter2('test task - ParforProgressStarter2', N, 0.1, do_debug);

    parfor i = 1 : N
        rand(1, 10000);
        ppm.increment(i);
    end;
    delete(ppm);
    
    bla = toc(this);
    disp(['ParforProgressStressTest2 running time: ' num2str(bla) 's.']);
    
end
%% EOF
