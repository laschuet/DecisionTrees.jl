using DecisionTrees
using Base.Test

cars = readdlm(joinpath(Pkg.dir("DecisionTrees"), "test/data/car.data"), ',')
println(cars)

header = ["buying", "maint", "doors", "persons", "lug_boot", "safety", "class"]

ent = entropy(cars, 7)
@test ent >= 0 && ent <= 1
println(ent)
