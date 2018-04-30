__precompile__()
module DecisionTrees

using StatsBase

export entropy

"""Compute the entropy of the specified dataset."""
function entropy(dataset::Array{Any, 2}, target::Int)
    class = dataset[:, target]
    prop_vals = collect(values(proportionmap(class)))
    return -mapreduce(p -> p * log(p), +, 0, prop_vals)
end

end # module DecisionTrees
