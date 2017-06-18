module ParallelCMDs
@assert(VERSION >= v"0.5", "Julia version 0.5 or newer required")

export run_parloop_system

sprintf(args...) = eval(:@sprintf($(args...)))

function run_cmd(cmdstr::String)
    cmd=`$(split(cmdstr))`;
    run_cmd(cmd)
end

function run_cmd(cmd::Cmd)
    s=0;
    o="";
    e="";
    try
        o=readstring(cmd);
        s=0;
    catch e
        s=1;
    end
    s, o, e;
end

"""
run_parloop_system - runs system commands in parpool

Status,Success = run_parloop_system(SysTmpl,CmdArgs,Verb)

    where:

        SysTmpl - string with template for the command

        CmdArgs - cell array of cell arrays with arguments to systmpl

        Verb    - optional boolean flag for verbose output

        Status  - cumulative status of all commands (0 is OK)

        Success - array of [exit_status]
                where exit_status==0 is OK

Example arguments:

    systmpl = "echo char=%s int=%d";

    cmdargs = ["a" 1;"b" 2; "c" 2; "d" 4]

"""
function run_parloop_system(systmpl::String,cmdargs::Array)
    run_parloop_system(systmpl,cmdargs,false)
end

function run_parloop_system(systmpl::String,cmdargs::Array,verb::Bool)

    N::Int32=size(cmdargs)[1]
    cmd::Array{String}=[]
    status::Int32=0
    success::Array{Int32,1}=zeros(Int32,N)
    
    for i=1:N
        myargs=cmdargs[i,:]
        dummy=sprintf(systmpl,myargs...)
        push!(cmd,dummy)
    end

    cmd_trace=pmap(run_cmd,cmd;retry_n=1)

    for i=1:N
        success[i]=abs(cmd_trace[i][1])
        if cmd_trace[i][1]!=0
            println("Fail : "*cmd[i]*" / ",cmd_trace[i])
        elseif verb
            println("Done : "*cmd[i]*" / ",cmd_trace[i])
        end
    end
    status=sum(success)

    status, success
end

end
