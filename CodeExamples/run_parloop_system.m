function [Status Successes] = run_parloop_system(systmpl,cmdargs,verb)
% run_parloop_system - runs system commands in parpool
%
% [Status Success] = run_parloop_system(SysTmpl,CmdArgs,Verb)
%   where:
%       SysTmpl - string with template for the command
%       CmdArgs - cell array of cell arrays with arguments to systmpl
%       Verb    - optional flag for verbose output
%       Status  - cumulative status of all commands (0 is OK)
%       Success - array of [command_index labindex exit_status]
%               command_index: 1:length(CmdArgs)
%               exit_status: 0 is OK
%
% Creating input example
%   systmpl = 'echo iter=%d rand=%s';
%   for i=1:10
%     cmdargs{i}={i, sprintf('%f',rand(1))};
%   end
%

if ~exist('verb','var')
    verb=false;
end

nelm = length(cmdargs);
iter=[1:nelm];
status = distributed(ones(1,nelm));
mylab = distributed(zeros(1,nelm));

spmd
    ptime=ceil(nelm/numlabs);
    for i = drange(iter)
        pause(randi([1,ptime]));
        k=cmdargs{i};
        cmd = sprintf(systmpl,k{:});
        if verb
            fprintf('%4d: %s\n',labindex,cmd);
        end;
        mylab(1,i) = labindex;
        [status(1,i) results]=system(cmd);
        if status(1,i)
            fprintf('Error on %4d: %s\n',labindex,results);
        end
    end
end

status=gather(status);
Status = sum(gather(status));
if nargout>1
    Successes = [iter',mylab',status'];
end
