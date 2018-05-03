"""Compute the entropy of the specified dataset."""
function entropy(dataset::AbstractArray{T, 2}, target::Int,
                c::Integer=2) where {T}
    class = dataset[:, target]
    prop_vals = collect(values(proportionmap(class)))
    return -mapreduce(p -> p * log2(p), +, 0, prop_vals) / log2(c)
end

entropy(dataset::AbstractArray{T, 2}, target::String,
        header::AbstractArray{String}, c::Integer=2) where {T} =
    entropy(dataset, findfirst(header, target), c)

"""Compute the information gain of the specified attribute."""
function information_gain(dataset::AbstractArray{T, 2}, attribute::Int,
                        target::Int, c::Integer=2) where {T}
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

information_gain(dataset::AbstractArray{T, 2}, attribute::String, target::Int,
                header::AbstractArray{String}, c::Integer=2) where {T} =
    information_gain(dataset, findfirst(header, attribute), target, c)

information_gain(dataset::AbstractArray{T, 2}, attribute::Int, target::String,
                header::AbstractArray{String}, c::Integer=2) where {T} =
    information_gain(dataset, attribute, findfirst(header, target), c)
