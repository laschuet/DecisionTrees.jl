__precompile__()
module DecisionTrees

using StatsBase

export attribute,
        children,
        entropy,
        information_gain,
        Node,
        num_children

include("measures.jl")
include("node.jl")

end # module DecisionTrees
