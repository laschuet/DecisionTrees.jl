module DecisionTrees

using Printf

export children,
    class,
    entropy,
    id3,
    information_gain,
    nchildren,
    Node,
    value

include("algorithms.jl")
include("measures.jl")
include("node.jl")

end # module DecisionTrees
