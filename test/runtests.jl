using DecisionTrees
using Base.Test

cars = readdlm(joinpath(Pkg.dir("DecisionTrees"), "test/data/car.data"), ',')
println(cars)

header = ["buying", "maint", "doors", "persons", "lug_boot", "safety", "class"]

@testset "entropy" begin
    ent = entropy(cars, 7)
    @test ent >= 0 && ent <= 1
    println("entr=$ent")
end

@testset "information_gain" begin
    for i in 1:6
        ig = information_gain(cars, i, 7)
        @test ig >= 0 && ig <= 1
        println("ig $(header[i])=$ig")
    end
end

@testset "node" begin
    ent = entropy(cars, 7)
    root = Node(header[1], ent, information_gain(cars, 1, 7), [])
    println(root)

    println(root.children)
    push!(root, root)
    println(root.children)

    println(root.children)
    append!(root, [root, root])
    println(root.children)
end
