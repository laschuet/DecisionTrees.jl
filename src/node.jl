"""
    Node

Decision tree node type.
"""
struct Node
    attr::String
    entr::Real
    ig::Real
    children::AbstractArray{Node}
end
Node() = Node("", 0, 1, [])
Node(attr::String, children::AbstractArray{T}) where {T} =
    Node(attr, 0, 1, children)

"""Access a node's attribute."""
attribute(n::Node) = n.attr

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

# Display the specified node
Base.show(io::IO, n::Node) =
    @printf(io, "[%s | entr=%.4f, ig=%.4f]", n.attr, n.entr, n.ig)
