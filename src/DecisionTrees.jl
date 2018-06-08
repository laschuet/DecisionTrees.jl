__precompile__()
module DecisionTrees

export attribute,
    children,
    class,
    dataset,
    entropy,
    id3,
    information_gain,
    Node,
    num_children

include("algorithms.jl")
include("measures.jl")
include("node.jl")

end # module DecisionTrees
