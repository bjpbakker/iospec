Number primes := method(
  n := self
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

describe ("Primes") do (
  it ("gets factors for 1") do (
    1 primes should == list()
  )

  it ("gets factors for 2") do (
    2 primes should == list(2)
  )

  it ("gets factors for 3") do (
    3 primes should == list(3)
  )

  it ("gets factors for 4") do (
    4 primes should == list(2,2)
  )

  it ("gets factors for 8") do (
    8 primes should == list(2,2,2)
  )

  it ("gets factors for 9") do (
    9 primes should == list(3,3)
  )
)

