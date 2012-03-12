function ppm = ParforProgressStarter2(s, n, percentage, do_debug)
% Starter function for parfor progress-monitor, that will automatically 
% choose between a text or a GUI progress monitor. You can use this 
% progress-monitor in both for and parfor loops.
%
% ParforProgressStarter2 is the successor of ParforProgressStarter - it is 
% roughly 12 times more performant during GUI mode!
% 
% you should use it like this:
% 
%   N = 1000;
%   try % Initialization
%       ppm = ParforProgressStarter2('test', N, 0.1);
%   catch me % make sure "ParforProgressStarter2" didn't get moved to a different directory
%       if strcmp(me.message, 'Undefined function or method ''ParforProgressStarter2'' for input arguments of type ''char''.')
%           error('ParforProgressStarter2 not in path.');
%       else
%           % this should NEVER EVER happen.
%           msg{1} = 'Unknown error while initializing "ParforProgressStarter2":';
%           msg{2} = me.message;
%           print_error_red(msg);
%           % backup solution so that we can still continue.
%           ppm.increment = nan(1, nbr_files);
%       end
%   end
%
%   parfor i = 1 : N
%       your_crazy_function();
%       ppm.increment(i);
%   end
%
%   delete(ppm);
%
% 
% Copyright (c) 2010-2012, Andreas Kotowicz
%
    %%

    if nargin < 2
        disp('usage: ppm = ParforProgressStarter2( text, number_runs, update_percentage)');
        ppm = [];
        return;
    end
    
    if nargin < 3
        percentage = 0.1;
    end
    
    if nargin < 4
        do_debug = 0;
    end

    %% check for old matlab versions.
    % - everything before 2008b (7.7) can cause trouble (because of saveobj /
    % loadobj)
    % - Sometimes we also had problems with windows systems where the 
    % javaaddpath doesn't seem to work with matlabpool. This should be
    % fixed now.
    % - We also need to check if we are running in a text console or if X 
    % is here.
    % - In addition, jvm might be disabled.
    OldVersion = 0;
    if get_matlab_version() < 7.07 || usejava('awt') == 0 %|| IsWindows == 1
        OldVersion = 1;
    end
    
    no_java = 0;
    if usejava('jvm') == 0
        no_java = 1;
    end
    
    %% add directory to javapath and path
    a = which(mfilename);
    dir_to_add = fileparts(a);
    
    pool_slaves = pool_size();
    if pool_slaves > 0
        if no_java == 0
            pctRunOnAll(['javaaddpath({''' dir_to_add '''})']);
        end
        pctRunOnAll(['addpath(''' dir_to_add ''')']);
    else
        if no_java == 0
            javaaddpath({dir_to_add});
        end
        addpath(dir_to_add);
    end
    
    %%
    if OldVersion == 1
        disp('Progress will update in arbitrary order.');
        ppm = ParforProgressConsole2(s, n, percentage);
    else
        ppm = ParforProgress2(s, n, percentage, do_debug);
    end
    
end
%% EOF
