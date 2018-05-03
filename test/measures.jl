@testset "entropy" begin
    ent = entropy(cars, 7, 4)
    ent2 = entropy(cars, "class", header, 4)
    @test ent >= 0 && ent <= 1
    @test ent2 >= 0 && ent2 <= 1
    @test ent == ent2
end

@testset "information gain" begin
    for i in 1:6
        ig = information_gain(cars, i, 7, 4)
        ig2 = information_gain(cars, header[i], "class", header, 4)
        ig3 = information_gain(cars, header[i], 7, header, 4)
        ig4 = information_gain(cars, i, "class", header, 4)
        @test ig >= 0 && ig <= 1
        @test ig2 >= 0 && ig2 <= 1
        @test ig3 >= 0 && ig3 <= 1
        @test ig4 >= 0 && ig4 <= 1
        @test ig == ig2 == ig3 == ig4
    end
end
