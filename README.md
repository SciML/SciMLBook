# 18.337J/6.338J: Parallel Computing and Scientific Machine Learning (Spring 2023)
## Professor Alan Edelman (and Philip the Corgi)
## MW 3:00 to 4:30 @ Room 2-190
## TA and Office hours: (To be confirmed)
## [Piazza Link](https://piazza.com/mit/spring2023/18337)
## [Canvas](https://canvas.mit.edu/courses/18760) will only be used for homework and project (+proposal) submission and nothing else.

## Classes are taped. Another great resource is Chris Rackauckas' videos of 2021 spring class. See [SciMLBook](https://book.sciml.ai/).

## Announcement:
 
There will be a small number of homeworks, followed by the final project. 
Everyone needs to present their work and submit a project report. 

Final Project presentations : April 26 to May 15

Final Project reports due: May 15


# Lecture Schedule (tentative)
|#|Day| Date |  Topic | [SciML](https://book.sciml.ai/) lecture | Materials |
|-|-|------|------|-----|--|
|1|M| 2/6 | Intro to Julia.  My Two Favorite Notebooks. |  |   [[Julia is fast]](https://github.com/mitmath/18337/blob/master/lecture1/Julia%20is%20fast.ipynb), [[AutoDiff]](https://github.com/mitmath/18337/blob/master/lecture1/AutoDiff.ipynb), [[autodiff video]](https://www.youtube.com/watch?v=vAp6nUMrKYg),[[The Parallel Dream]]()
|2|W|2/8| Matrix Calculus I | | [[pdf]](https://github.com/mitmath/18337/blob/master/lecture2/The%20Julia%20HPC%20dream%20-%20Jupyter%20Notebook.pdf),[[video]](https://www.youtube.com/watch?v=M2i7sSRcSIw)
|3|M|2/13| Matrix Calculus II ||  [[video]](https://www.youtube.com/watch?v=GhBARuHEydM)
|4|W|2/15| Automatic differentiation I : Forward mode AD |[8][8] |   [[video 1]](https://youtu.be/C3vf9ZFYbjI)      [[video2]](https://youtu.be/hKHl68Fdpq4) 
|5|T|2/21| Automatic differentiation II : Reverse mode AD |[10][10]|  [[video]](https://www.youtube.com/watch?v=eca6kcFntiE)|
|6|W|2/22| Models of Parallelism |[6][6]|  [[video]](https://www.youtube.com/watch?v=EP5VWwPIews)
|7|M|2/27| Multithreading, Static and Dynamic Scheduling  | | [Slides](https://github.com/mitmath/18337/blob/master/lecture%207/siampp2022.pdf)
|8|W|3/1| GPU Parallelism I |[7][7]| [[video 1]](https://www.youtube.com/watch?v=riAbPZy9gFc),[[video2]](https://www.youtube.com/watch?v=HMmOk9GIhsw)
|9|M|3/6| GPU Paralellism II | | [[video]](https://www.youtube.com/watch?v=zHPXGBiTM5A), [[Eig&SVD derivatives notebooks]](https://github.com/mitmath/18337/tree/master/lecture9), [[2022 IAP Class Matrix Calculus]](https://github.com/mitmath/matrixcalc)
|10|W|3/8| MPI |  |  [Slides](https://github.com/SciML/SciMLBook/blob/spring21/lecture12/MPI.jl.pdf),  [[video, Lauren Milichen]](https://www.youtube.com/watch?v=LCIJj0czofo),[[Performance Metrics]](https://github.com/mitmath/18337/blob/spring21/lecture12/PerformanceMetricsSoftwareArchitecture.pdf) see p317,15.6
|11|M|3/13| Differential Equations I  | [9][9]| 
|12|W|3/15| Differential Equations II   |[10][10] |
|13|M|3/20| Neural ODE  |[11][11] | 
|14|W|3/22|   |[13][13] |
| | | | Spring Break |
|15|M|4/3|   | | [GPU Slides](https://docs.google.com/presentation/d/1npryMMe7JyLLCLdeAM3xSjLe5Q54eq0QQrZg5cxw-ds/edit?usp=sharing) [Prefix Materials](https://github.com/mitmath/18337/tree/master/lecture%2013)
|16|W|4/5|  Convolutions and PDEs | [14][14] |
|17|M|4/10|   Chris R on ode adjoints, PRAM Model |[11][11] | [[video]](https://www.youtube.com/watch?v=KCTfPyVIxpc)|
|18|W|4/12|  Linear and Nonlinear System Adjoints | [11][11] | [[video]](https://www.youtube.com/watch?v=KCTfPyVIxpc)|
|  |M|4/17| Patriots' Day
|19|W|4/19|  Lagrange Multipliers, Spectral Partitioning ||  [Partitioning Slides](https://github.com/alanedelman/18.337_2018/blob/master/Lectures/Lecture13_1022_SpectralPartitioning/Partitioning.ppt)|       |
|20|M|4/24|  |[15][15]| [[video]](https://www.youtube.com/watch?v=YuaVXt--gAA),[notes on adjoint](https://github.com/mitmath/18337/blob/master/lecture20/adjointpde.pdf)|
|21|W|4/26| Project Presentation I |
|22|M|5/1| Project Presentation II | [Materials](https://github.com/mitmath/18337/tree/master/lecture%2022)
|23|W|5/3| Project Presentation III | [16][16] | [[video](https://www.youtube.com/watch?v=32rAwtTAGdU)]
|24|M|5/8|  Project Presentation IV |  
|25|W|5/10| Project Presentation V |
|26|M|5/15| Project Presentation VI|


[1]:https://book.sciml.ai/notes/01/
[2]:https://book.sciml.ai/notes/02/
[3]:https://book.sciml.ai/notes/03/
[4]:https://book.sciml.ai/notes/04/
[5]:https://book.sciml.ai/notes/05/
[6]:https://book.sciml.ai/notes/06/
[7]:https://book.sciml.ai/notes/07/
[8]:https://book.sciml.ai/notes/08-Forward-Mode_Automatic_Differentiation_(AD)_via_High_Dimensional_Algebras/
[9]:https://book.sciml.ai/notes/09/
[10]:https://book.sciml.ai/notes/10-Basic_Parameter_Estimation-Reverse-Mode_AD-and_Inverse_Problems/
[11]:https://book.sciml.ai/notes/11/
[13]:https://book.sciml.ai/notes/13/
[14]:https://book.sciml.ai/notes/14/
[15]:https://book.sciml.ai/notes/15/
[16]:https://book.sciml.ai/notes/16/

# Lecture Summaries and Handouts


## Lecture 1: Introduction and Syllabus

### Lecture and Notes


# Homeworks



# Final Project

For the second half of the class students will work on the final project. A one-page final project 
proposal must be sumbitted by March 24 Friday, through canvas. 

Last three weeks (tentative)  will be student presentations. 

## Possible Project Topics

One possibility is to review an interesting algorithm not covered in the course
and develop a high performance implementation. Some examples include:

- High performance PDE solvers for specific PDEs like Navier-Stokes
- Common high performance algorithms (Ex: Jacobian-Free Newton Krylov for PDEs)
- Recreation of a parameter sensitivity study in a field like biology,
  pharmacology, or climate science
- [Augmented Neural Ordinary Differential Equations](https://arxiv.org/abs/1904.01681)
- [Neural Jump Stochastic Differential Equations](https://arxiv.org/pdf/1905.10403.pdf)
- Parallelized stencil calculations
- Distributed linear algebra kernels
- Parallel implementations of statistical libraries, such as survival statistics
  or linear models for big data. Here's [one example parallel library)](https://github.com/harrelfe/rms)
  and a [second example](https://bioconductor.org/packages/release/data/experiment/html/RegParallel.html).
- Parallelization of data analysis methods
- Type-generic implementations of sparse linear algebra methods
- A fast regex library
- Math library primitives (exp, log, etc.)

Another possibility is to work on state-of-the-art performance engineering.
This would be implementing a new auto-parallelization or performance enhancement.
For these types of projects, implementing an application for benchmarking is not
required, and one can instead benchmark the effects on already existing code to
find cases where it is beneficial (or leads to performance regressions).
Possible examples are:

- [Create a system for automatic multithreaded parallelism of array operations](https://github.com/JuliaLang/julia/issues/19777) and see what kinds of packages end up more efficient
- [Setup BLAS with a PARTR backend](https://github.com/JuliaLang/julia/issues/32786)
  and investigate the downstream effects on multithreaded code like an existing
  PDE solver
- [Investigate the effects of work-stealing in multithreaded loops](https://github.com/JuliaLang/julia/issues/21017)
- Fast parallelized type-generic FFT. Starter code by Steven Johnson (creator of FFTW)
  and Yingbo Ma [can be found here](https://github.com/YingboMa/DFT.jl)
- Type-generic BLAS. [Starter code can be found here](https://github.com/JuliaBLAS/JuliaBLAS.jl)
- Implementation of parallelized map-reduce methods. For example, `pmapreduce`
  [extension to `pmap`](https://docs.julialang.org/en/v1/manual/parallel-computing/index.html)
  that adds a paralellized reduction, or a fast GPU-based map-reduce.
- Investigating auto-compilation of full package codes to GPUs using tools like
  [CUDAnative](https://github.com/JuliaGPU/CUDAnative.jl) and/or
  [GPUifyLoops](https://github.com/vchuravy/GPUifyLoops.jl).
- Investigating alternative implementations of databases and dataframes.
  [NamedTuple backends of DataFrames](https://github.com/JuliaData/DataFrames.jl/issues/1335), alternative [type-stable DataFrames](https://github.com/FugroRoames/TypedTables.jl), defaults for CSV reading and other large-table formats
  like [JuliaDB](https://github.com/JuliaComputing/JuliaDB.jl).

Additionally, Scientific Machine Learning is a wide open field with lots of
low hanging fruit. Instead of a review, a suitable research project can be
used for chosen for the final project. Possibilities include:

- Acceleration methods for adjoints of differential equations
- Improved methods for Physics-Informed Neural Networks
- New applications of neural differential equations
- Parallelized implicit ODE solvers for large ODE systems
- GPU-parallelized ODE/SDE solvers for small systems





