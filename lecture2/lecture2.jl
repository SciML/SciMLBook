# Flattening
A = 1:9
A[3]
A[2]
A[3,2]
i,j = 3,2
A[i + (j-1)*3]
reshape(A,(3,3))[3,2]  # It's just an index scheme

# Memory Order Matters
A = rand(100,100)
B = rand(100,100)
C = rand(100,100)
using BenchmarkTools

function inner_rows!(C,A,B)
  for i in 1:100, j in 1:100
    C[i,j] = A[i,j] + B[i,j]
  end
end
@btime inner_rows!(C,A,B)

function inner_cols!(C,A,B)
    for j in 1:100, i in 1:100
      C[i,j] = A[i,j] + B[i,j]
    end
  end
  @btime inner_cols!(C,A,B)


  # Heap vs Stack
  function inner_alloc!(C,A,B)
    
    for j in 1:100, i in 1:100
      val = [A[i,j] + B[i,j]]  # this is a vector of length 1, but Julia doesn't know
      C[i,j] = val[1]
    end
  end
  @btime inner_alloc!(C,A,B)

  function inner_noalloc!(C,A,B)
    for j in 1:100, i in 1:100
      val = A[i,j] + B[i,j]
      C[i,j] = val[1]  # this is a scalar which Julia does know
    end
  end
  @btime inner_noalloc!(C,A,B)

