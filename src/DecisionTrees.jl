__precompile__()
module DecisionTrees

using StatsBase

export entropy,
        information_gain,
        Node,
        num_children

include("measures.jl")
include("node.jl")

end # module DecisionTrees
