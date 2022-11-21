# Parallel Computing and Scientific Machine Learning (SciML): Methods and Applications

[![DOI](https://zenodo.org/badge/205191601.svg)](https://zenodo.org/badge/latestdoi/205191601)

This book is a compilation of lecture notes from the MIT Course 18.337J/6.338J: Parallel Computing and Scientific Machine Learning. 
Links to the old notes https://mitmath.github.io/18337 will redirect here.

This repository is meant to be a live document, updating to continuously add the latest details on methods from the field of 
scientific machine learning and the latest techniques for high-performance computing.

To view this book, go to [book.sciml.ai](https://book.sciml.ai/).

## Editing the SciML Book

This is a Quarto book. Prose is authored in Quarto Mardown (`qmd`) files or
Jupyter (`ipynb`) notebooks and code execution occurs via the Jupyter engine.
For most efficient editing experience, precompile a system image and build a
custom Jupyter kernel named `scimlbook-1.8`. This is only done once.

First, precomile a system image for the book project.

1. Open SciMLBook in VS Code
1. Open command pallete (Ctrl + Shift + P)
1. `Tasks: Run Build Task`
1. `Julia: Build custom sysimage for current environment` (will take > 20 minutes)
1. Fire up a Julia REPL
1. `using IJulia`
1. `IJulia.installkernel("SciMLBook", "--project=path/to/SciMLBook --sysimage=/path/to/SciMLBook/JuliaSysimage.(so|dll)")`
1. Open SciMLBook in VS Code
1. Open any `*.qmd` file
1. Click Render

## Todo

- [ ] Transition all references to appendix with BibTex format
- [ ] Move YouTube videos to common (suplemental resources)location
- [ ] Update `Juno.profiler()` to equivalent VS Code version