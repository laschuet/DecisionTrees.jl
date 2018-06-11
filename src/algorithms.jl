"""Train a decision tree using the ID algorithm."""
function id3(dataset::AbstractArray{T, 2}, target::Integer,
            attributes::AbstractArray{String}) where {T}
    targets = dataset[:, target]
    classes = unique(targets)
    nclasses = length(classes)
    node = Node()

    # Check if there is only one class left
    if nclasses == 1
        node.class = classes[1]
        return node
    end

    # Determine major class if there are no attributes left
    if isempty(attributes)
        classcounts = zeros(nclasses)
        for i in 1:nclasses
            classcounts[i] = count(t -> t == classes[i], targets)
        end
        node.class = classes[indmax(classcounts)]
        return node
    end

    # Determine best attribute for the node
    igs = []
    for attr in 1:length(attributes)
        ig = information_gain(dataset, attr, target, nclasses)
        push!(igs, ig)
    end
    maxind = indmax(igs)
    node.value = attributes[maxind]
    node.entr = entropy(dataset, target, nclasses)
    node.ig = igs[maxind]

    # Add children for each possible value of the attribute
    vals = dataset[:, maxind]
    uniques = unique(vals)
    for i in 1:length(uniques)
        uni = uniques[i]
        subdataset = dataset[vals .== uni, :]
        if isempty(subdataset)
            classcounts = zeros(nclasses)
            for i in 1:nclasses
                classcounts[i] = count(t -> t == classes[i], targets)
            end
            child = Node()
            child.class = classes[indmax(classcounts)]
            push!(node, child)
        else
            remattributes = filter(a -> a != node.value, attributes)
            subtree = id3(subdataset, target, remattributes)
            push!(node, subtree)
        end
    end

    return node
end
