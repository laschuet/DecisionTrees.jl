using DecisionTrees
using DelimitedFiles
using Test

file = joinpath(dirname(pathof(DecisionTrees)), "..", "test/data/car.data")
cars = readdlm(file, ',')
header = ["buying", "maint", "doors", "persons", "lug_boot", "safety", "class"]

@testset "data" begin
    @test size(cars, 1) == 1728
    @test size(cars, 2) == length(header) == 7
end

include("algorithms.jl")
include("measures.jl")
include("node.jl")
