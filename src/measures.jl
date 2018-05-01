"""Compute the entropy of the specified dataset."""
function entropy(dataset::Array{Any, 2}, target::Int)
    class = dataset[:, target]
    prop_vals = collect(values(proportionmap(class)))
    return -mapreduce(p -> p * log(p), +, 0, prop_vals)
end

entropy(dataset::Array{Any, 2}, target::String, header::Array{String}) =
        entropy(dataset, findfirst(header, target))

"""Compute the information gain of the specified attribute."""
function information_gain(dataset::Array{Any, 2}, attribute::Int, target::Int)
    n = size(dataset, 1)
    attr = dataset[:, attribute]
    uniques = unique(attr)

    attr_sub_entropy = mapreduce(u -> begin
        subset = dataset[attr .== u, :]
        return size(subset, 1) / n * entropy(subset, target)
    end, +, 0, uniques)

    return entropy(dataset, target) - attr_sub_entropy
end

information_gain(dataset::Array{Any, 2}, attribute::String, target::String,
        header::Array{String}) =
                information_gain(dataset, findfirst(header, attribute),
                        findfirst(header, target))
information_gain(dataset::Array{Any, 2}, attribute::String, target::Int,
        header::Array{String}) =
                information_gain(dataset, findfirst(header, attribute), target)
information_gain(dataset::Array{Any, 2}, attribute::Int, target::String,
        header::Array{String}) =
                information_gain(dataset, attribute, findfirst(header, target))
