@testset "constructors" begin
    node = Node()
    @test isa(node, Node) && node.attr == "" && node.class == "" &&
        node.entr == 0 && node.ig == 1 && node.children == []

    node2 = Node("", "", 0, 1, [])
    @test isa(node2, Node) && node2.attr == "" && node.class == "" &&
        node2.entr == 0 && node2.ig == 1 && node2.children == []

    node3 = Node("attribute")
    @test isa(node3, Node) && node3.attr == "attribute" && node.class == "" &&
        node3.entr == 0 && node3.ig == 1 && node3.children == []

    node4 = Node("", [node3])
    @test isa(node4, Node) && node4.attr == "" && node.class == "" &&
        node4.entr == 0 && node4.ig == 1 && node4.children == [node3]
end

@testset "accessors" begin
    node = Node("", "", 0, 1, [])
    @test attribute(node) == node.attr
    @test class(node) == node.class
    @test entropy(node) == node.entr
    @test information_gain(node) == node.ig
    @test children(node) == node.children
end

@testset "properties" begin
    node = Node("", "", 0, 1, [])
    @test num_children(node) == 0
end

@testset "operators" begin
    node = Node("", "", 0, 1, [])
    node2 = Node("", "", 0, 1, [])
    @test node == node2
end

@testset "mutations" begin
    root = Node("", "", 0, 1, [])
    node = Node("", "", 0, 1, [])
    prev_num_children = length(root.children)
    push!(root, node)
    @test length(root.children) == prev_num_children + 1

    root = Node("", "", 0, 1, [])
    node = Node("", "", 0, 1, [])
    prev_num_children = length(root.children)
    append!(root, [node, node, node])
    @test length(root.children) == prev_num_children + 3
end

@testset "show" begin
    node = Node("", "", 0, 1, [])
    @test sprint(show, node) == "[] (entr=0.0000, ig=1.0000)"

    node2 = Node("2", "", 0, 1, [])
    @test sprint(show, node2) == "[2] (entr=0.0000, ig=1.0000)"

    node3 = Node("3", "", 0, 1, [])
    node4 = Node("4", "", 0, 1, [])
    push!(node, node2)
    push!(node2, node4)
    push!(node2, node4)
    push!(node, node3)
    println(node)
    @test sprint(show, node) == """[] (entr=0.0000, ig=1.0000)
    |-- [2] (entr=0.0000, ig=1.0000)
    |   |-- [4] (entr=0.0000, ig=1.0000)
    |   `-- [4] (entr=0.0000, ig=1.0000)
    `-- [3] (entr=0.0000, ig=1.0000)"""
end
