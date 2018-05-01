@testset "constructors" begin
    node = Node()
    node2 = Node("", 0, 1, [])
    @test isa(node, Node) && node.attr == "" && node.entr == 0 &&
            node.ig == 1 && node.children == []
    @test isa(node2, Node) && node2.attr == "" && node2.entr == 0 &&
            node2.ig == 1 && node2.children == []
end

@testset "accessors" begin
    node = Node("", 0, 1, [])
    @test attribute(node) == node.attr
    @test entropy(node) == node.entr
    @test information_gain(node) == node.ig
    @test children(node) == node.children
end

@testset "properties" begin
    node = Node("", 0, 1, [])
    @test num_children(node) == 0
end

@testset "mutations" begin
    root = Node("", 0, 1, [])
    node = Node("", 0, 1, [])
    prev_num_children = length(root.children)
    push!(root, node)
    @test length(root.children) == prev_num_children + 1

    root = Node("", 0, 1, [])
    node = Node("", 0, 1, [])
    prev_num_children = length(root.children)
    append!(root, [node, node, node])
    @test length(root.children) == prev_num_children + 3
end
