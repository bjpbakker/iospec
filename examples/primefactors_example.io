PrimeFactors := Object clone do (
  factorsFor := method(n,
    factors := list
    candidate := 2
    while (n > 1,
      while (n % candidate == 0,
        factors append(candidate)
        n = n / candidate
      )
      candidate = candidate + 1
    )
    factors
  )
)

describe (PrimeFactors) do (
  it ("gets factors for 1") do (
    PrimeFactors factorsFor(1) should == list()
  )

  it ("gets factors for 2") do (
    PrimeFactors factorsFor(2) should == list(2)
  )

  it ("gets factors for 3") do (
    PrimeFactors factorsFor(3) should == list(3)
  )

  it ("gets factors for 4") do (
    PrimeFactors factorsFor(4) should == list(2,2)
  )

  it ("gets factors for 8") do (
    PrimeFactors factorsFor(8) should == list(2,2,2)
  )

  it ("gets factors for 9") do (
    PrimeFactors factorsFor(9) should == list(3,3)
  )
)

