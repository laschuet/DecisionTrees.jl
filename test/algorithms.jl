@testset "id3" begin
    attributes = filter(a -> a != "class", header)
    tree = id3(cars, 7, attributes)
    println(tree)
end
