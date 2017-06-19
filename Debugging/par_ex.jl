export par_ex_slow, par_ex_fast

"""
This example shows implicit blocking, which is hard to find without debugging tools
"""
function par_ex_slow(x::AbstractArray)

    # Get a list of workers avilable
    pids = workers()
    
    refs = Vector{Any}(nworkers())
    
    for i = 1:nworkers()

        refs[i] = remotecall(debug_ex, pids[i], x) 
    
    end
   
    results = [fetch(refs[r]) for r = 1:length(refs)]

    return results

end

"""
This example should not have any implicit blocking
"""
function par_ex_fast(x::AbstractArray)

    # Get a list of workers avilable
    pids = workers()
    refs = Vector{Any}(nworkers())
    
    @sync begin
    for i = 1:nworkers()

        @async refs[i] = remotecall_fetch(debug_ex, pids[i], x) 
    
    end
    end #sync
   
    return refs

end
