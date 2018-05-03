"""Compute the entropy of the specified dataset."""
function entropy(dataset::AbstractArray{T, 2}, target::Integer,
                c::Integer=2) where {T}
    class = dataset[:, target]
    n = length(class)
    uniques = unique(class)

    return -mapreduce(u -> begin
        subset = dataset[class .== u, :]
        p = size(subset, 1) / n
        return p * log2(p)
    end, +, 0, uniques) / log2(c)
end

entropy(dataset::AbstractArray{T, 2}, target::String,
        header::AbstractArray{String}, c::Integer=2) where {T} =
    entropy(dataset, findfirst(header, target), c)

"""Compute the information gain of the specified attribute."""
function information_gain(dataset::AbstractArray{T, 2}, attribute::Integer,
                        target::Integer, c::Integer=2) where {T}
    n = size(dataset, 1)
    attr = dataset[:, attribute]
    uniques = unique(attr)

    attr_sub_entropy = mapreduce(u -> begin
        subset = dataset[attr .== u, :]
        return size(subset, 1) / n * entropy(subset, target, c)
    end, +, 0, uniques)

    return entropy(dataset, target) - attr_sub_entropy
end

information_gain(dataset::AbstractArray{T, 2}, attribute::String,
                target::String, header::AbstractArray{String},
                c::Integer=2) where {T} =
    information_gain(dataset, findfirst(header, attribute),
                    findfirst(header, target), c)

information_gain(dataset::AbstractArray{T, 2}, attribute::String,
                target::Integer, header::AbstractArray{String},
                c::Integer=2) where {T} =
    information_gain(dataset, findfirst(header, attribute), target, c)

information_gain(dataset::AbstractArray{T, 2}, attribute::Integer,
                target::String, header::AbstractArray{String},
                c::Integer=2) where {T} =
    information_gain(dataset, attribute, findfirst(header, target), c)
