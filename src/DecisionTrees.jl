__precompile__()
module DecisionTrees

using StatsBase

export entropy,
        information_gain,
        Node

"""
    Node

Decision tree node type.
"""
struct Node
    attr::String
    entr::Real
    ig::Real
    children::Array{Node}
end

"""Add the specified child to the node."""
Base.push!(n::Node, child::Node) = push!(n.children, child)

Base.show(io::IO, n::Node) =
        @printf(io, "[%s | entr=%.4f, ig=%.4f]", n.attr, n.entr, n.ig)

"""Compute the entropy of the specified dataset."""
function entropy(dataset::Array{Any, 2}, target::Int)
    class = dataset[:, target]
    prop_vals = collect(values(proportionmap(class)))
    return -mapreduce(p -> p * log(p), +, 0, prop_vals)
end

"""Compute the information gain of the specified attribute."""
function information_gain(dataset::Array{Any, 2}, attribute::Int, target::Int)
    n = size(dataset, 1)
    attr = dataset[:, attribute]
    uniques = unique(attr)

    attr_sub_entropy = mapreduce(u -> begin
        subset = dataset[attr .== u, :]
        return size(subset, 1) / n * entropy(subset, target)
    end, +, 0, uniques)

    return entropy(dataset, target) - attr_sub_entropy
end

end # module DecisionTrees
