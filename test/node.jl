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

@testset "properties" begin
    node = Node("", 0, 1, [])
    node2 = Node("", 0, 1, [node])
    @test num_children(node) == 0
    @test num_children(node2) == 1
end
