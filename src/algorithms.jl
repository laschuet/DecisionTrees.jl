"""Train a decision tree using the ID algorithm."""
function id3(dataset::AbstractArray{T, 2}, class::Integer,
            header::AbstractArray{String}, c::Integer=2) where {T}
    root = Node()
    root.dataset = dataset
    remaining = [root]

    while !isempty(remaining)
        node = pop!(remaining)

        # If everything is classified perfectly, a child node has been found
        classes = unique(node.dataset[:, class])
        if length(classes) == 1
            node.class = classes[1]
            continue
        end

        # Determine best attribute using information gain
        igs = []
        for i in 1:size(node.dataset, 2)
            if i == class
                continue
            end
            ig = information_gain(node.dataset, i, class, c)
            push!(igs, ig)
        end
        maxind = indmax(igs)
        node.attr = header[maxind]
        node.entr = entropy(node.dataset, class, c)
        node.ig = igs[maxind]

        # Add children for each attribute's value
        attr = node.dataset[:, maxind]
        uniques = unique(attr)
        for i in 1:length(uniques)
            val = uniques[i]
            child = Node()
            child.dataset = node.dataset[attr .== val, :]
            push!(node, child)
            push!(remaining, child)
        end
    end

    return root
end
