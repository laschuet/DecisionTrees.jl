using Documenter
using DecisionTrees

makedocs(
    modules = [DecisionTrees],
    sitename = "DecisionTrees.jl",
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(repo = "github.com/laschuet/DecisionTrees.jl.git")
