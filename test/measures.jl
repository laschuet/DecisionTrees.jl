@testset "entropy" begin
    ent = entropy(cars, 7)
    @test ent >= 0 && ent <= 1
end

@testset "information gain" begin
    for i in 1:6
        ig = information_gain(cars, i, 7)
        @test ig >= 0 && ig <= 1
    end
end
