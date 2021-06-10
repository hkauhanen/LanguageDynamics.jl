using LanguageDynamics
using Documenter

DocMeta.setdocmeta!(LanguageDynamics, :DocTestSetup, :(using LanguageDynamics); recursive=true)

makedocs(;
    modules=[LanguageDynamics],
    authors="Henri Kauhanen <henri.kauhanen@uni-konstanz.de>",
    repo="https://github.com/hkauhanen/LanguageDynamics.jl/blob/{commit}{path}#{line}",
    sitename="LanguageDynamics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hkauhanen.github.io/LanguageDynamics.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Getting started" => "getting-started.md",
        "Philosophy" => "philosophy.md",
        "Examples" => "examples.md",
        "Reference" => ["Populations" => "populations.md",
                        "Interactors" => "interactors.md",
                        "Replicators" => "replicators.md",
                        "Auxiliaries" => "auxiliaries.md",
                        "All functions and types" => "all.md",
                        "The type hierarchies" => "type-hierarchies.md"]
    ],
)

deploydocs(;
    repo="github.com/hkauhanen/LanguageDynamics.jl",
    devbranch="main",
)
