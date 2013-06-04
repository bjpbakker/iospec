Coinchanger := Object clone do (
  denominations := list(100, 50, 25, 10, 5, 1)

  change := method(amount,
    if (amount == 0, return list)
    denomination := denominations detect(<= amount)
    list(denomination) appendSeq(change(amount - denomination))
  )
)

describe(Coinchanger) do (
  it ("changes from 1") do (
    subject change(1) should == list(1)
  )

  it ("changes from 2") do (
    subject change(2) should == list(1,1)
  )

  it ("changes from 3") do (
    subject change(3) should == list(1,1,1)
  )

  it ("changes from 5") do (
    subject change(5) should == list(5)
  )

  it ("changes from 10") do (
    subject change(10) should == list(10)
  )

  it ("changes from 25") do (
    subject change(25) should == list(25)
  )

  it ("changes from 50") do (
    subject change(50) should == list(50)
  )

  it ("changes from 100") do (
    subject change(100) should == list(100)
  )

  it ("changes from 67") do (
    subject change(67) should == list(50, 10, 5, 1, 1)
  )
)

