using DecisionTrees
using Base.Test

cars = readdlm(joinpath(Pkg.dir("DecisionTrees"), "test/data/car.data"), ',')
header = ["buying", "maint", "doors", "persons", "lug_boot", "safety", "class"]

@testset "examplary car data" begin
    @test size(cars, 1) == 1728
    @test size(cars, 2) == length(header) == 7

    display(cars)
end

include("measures.jl")
include("node.jl")
