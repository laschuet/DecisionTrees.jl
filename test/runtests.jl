using DecisionTrees
using Base.Test

cars = readdlm(joinpath(Pkg.dir("DecisionTrees"), "test/data/car.data"), ',')
println(cars)

header = ["buying", "maint", "doors", "persons", "lug_boot", "safety", "class"]

include("measures.jl")
include("node.jl")
