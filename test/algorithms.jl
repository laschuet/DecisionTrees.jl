@testset "id3" begin
    tree = id3(cars, 7, header, 4)
    println(tree)
end
