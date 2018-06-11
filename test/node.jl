@testset "constructors" begin
    node = Node()
    @test isa(node, Node) && node.value == "" && node.class == "" &&
        node.entr == 0 && node.ig == 1 && node.children == []

    node2 = Node("", "", 0, 1, [])
    @test isa(node2, Node) && node2.value == "" && node.class == "" &&
        node2.entr == 0 && node2.ig == 1 && node2.children == []

    node3 = Node("value")
    @test isa(node3, Node) && node3.value == "value" && node.class == "" &&
        node3.entr == 0 && node3.ig == 1 && node3.children == []

    node4 = Node("", [node3])
    @test isa(node4, Node) && node4.value == "" && node.class == "" &&
        node4.entr == 0 && node4.ig == 1 && node4.children == [node3]
end

@testset "accessors" begin
    node = Node("", "", 0, 1, [])
    @test class(node) == node.class
    @test entropy(node) == node.entr
    @test information_gain(node) == node.ig
    @test children(node) == node.children
    @test nchildren(node) == 0
    @test value(node) == node.value
end

@testset "properties" begin
    node = Node("", "", 0, 1, [])
    @test nchildren(node) == 0
end

@testset "operators" begin
    node = Node("", "", 0, 1, [])
    node2 = Node("", "", 0, 1, [])
    @test node == node2
end

@testset "mutations" begin
    root = Node("", "", 0, 1, [])
    node = Node("", "", 0, 1, [])
    prev_nchildren = length(root.children)
    push!(root, node)
    @test length(root.children) == prev_nchildren + 1

    root = Node("", "", 0, 1, [])
    node = Node("", "", 0, 1, [])
    prev_nchildren = length(root.children)
    append!(root, [node, node, node])
    @test length(root.children) == prev_nchildren + 3
end

@testset "show" begin
    node = Node("", "", 0, 1, [])
    @test sprint(show, node) == "()"

    node2 = Node("2", "", 0, 1, [])
    @test sprint(show, node2) == "[2] (entr=0.0000, ig=1.0000)"

    node3 = Node("3", "", 0, 1, [])
    node4 = Node("4", "", 0, 1, [])
    push!(node, node2)
    push!(node2, node4)
    push!(node2, node4)
    push!(node, node3)
    println(node)
    @test sprint(show, node) == """()
    |-- [2] (entr=0.0000, ig=1.0000)
    |   |-- [4] (entr=0.0000, ig=1.0000)
    |   `-- [4] (entr=0.0000, ig=1.0000)
    `-- [3] (entr=0.0000, ig=1.0000)"""
end
