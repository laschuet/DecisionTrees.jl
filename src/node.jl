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

"""Access a node's attribute."""
attribute(n::Node) = n.attr

"""Access a node's entropy."""
entropy(n::Node) = n.entr

"""Access a node's information gain."""
information_gain(n::Node) = n.ig

"""Access a node's children."""
children(n::Node) = n.children

"""Retrieve number of children for the specified node."""
num_children(n::Node) = length(n.children)

# Add the specified child to the node
Base.push!(n::Node, child::Node) = push!(n.children, child)

# Add all children to the node
Base.append!(n::Node, children::Array{Node}) = append!(n.children, children)

# Display the specified node
Base.show(io::IO, n::Node) =
        @printf(io, "[%s | entr=%.4f, ig=%.4f]", n.attr, n.entr, n.ig)
