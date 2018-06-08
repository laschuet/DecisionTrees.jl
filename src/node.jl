"""
    Node

Decision tree node type.
"""
mutable struct Node
    attr::String
    class::String
    dataset::AbstractArray{Any, 2}
    entr::Real
    ig::Real
    children::AbstractArray{Node}
end
Node() = Node("", "", Array{Any, 2}(0, 0), 0, 1, [])
Node(attr::String) = Node(attr, "", Array{Any, 2}(0, 0), 0, 1, [])
Node(attr::String, children::AbstractArray{Node}) =
    Node(attr, "", Array{Any, 2}(0, 0), 0, 1, children)

"""Access a node's attribute."""
attribute(n::Node) = n.attr

"""Access a node's class."""
class(n::Node) = n.class

"""Access a node's dataset."""
dataset(n::Node) = n.dataset

"""Access a node's entropy."""
entropy(n::Node) = n.entr

"""Access a node's information gain."""
information_gain(n::Node) = n.ig

"""Access a node's children."""
children(n::Node) = n.children

"""Retrieve number of children."""
num_children(n::Node) = length(n.children)

# Check for equality
Base.:(==)(x::Node, y::Node) =
    (x.attr == y.attr) & (x.entr == y.entr) & (x.ig == y.ig) &
        (x.children == y.children)

# Add the specified child to the node
Base.push!(n::Node, child::Node) = push!(n.children, child)

# Add all children to the node
Base.append!(n::Node, children::AbstractArray{Node}) =
    append!(n.children, children)

# Display the specified node and its ancestors
Base.show(io::IO, n::Node) = show(io, n)

"""Auxiliary function to display the node and its ancestors with indentation"""
function show(io::IO, n::Node, indent::Integer=0, islast::Bool=false)
    if indent > 1
        print(io, "|   " ^ (indent - 1))
    end
    if indent > 0
        islast ? print(io, "`-- ") : print(io, "|-- ")
    end

    @printf(io, "[%s] (entr=%.4f, ig=%.4f)", n.attr, n.entr, n.ig)

    succs = children(n)
    sz = num_children(n)
    for i in 1:sz
        println(io)
        show(io, succs[i], indent + 1, i == sz)
    end
end
