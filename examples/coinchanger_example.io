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
    change(1) should == list(1)
  )

  it ("changes from 2") do (
    change(2) should == list(1,1)
  )

  it ("changes from 3") do (
    change(3) should == list(1,1,1)
  )

  it ("changes from 5") do (
    change(5) should == list(5)
  )

  it ("changes from 10") do (
    change(10) should == list(10)
  )

  it ("changes from 25") do (
    change(25) should == list(25)
  )

  it ("changes from 50") do (
    change(50) should == list(50)
  )

  it ("changes from 100") do (
    change(100) should == list(100)
  )

  it ("changes from 67") do (
    change(67) should == list(50, 10, 5, 1, 1)
  )
)

