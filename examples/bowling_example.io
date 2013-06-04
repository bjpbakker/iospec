Bowling := Object clone do (
  init := method(
    newSlot("rolls", list)
  )

  hit := method(pins,
    rolls append(pins)
  )

  score := method(
    score := 0
    rollIndex := 0
    10 repeat (
      if (isStrike(rolls, rollIndex)) then (
        score = score + 10 + strikeBonus(rolls, rollIndex)
        rollIndex = rollIndex + 1
      ) elseif (isSpare(rolls, rollIndex)) then (
        score = score + 10 + spareBonus(rolls, rollIndex)
        rollIndex = rollIndex + 2
      ) else (
        score = score + rolls at(rollIndex) + rolls at(rollIndex + 1)
        rollIndex = rollIndex + 2
      )
    )
    score
  )

  isStrike := method(rolls, index,
    rolls at(index) == 10
  )

  strikeBonus := method(rolls, index,
    rolls at(index + 1) + rolls at(index + 2)
  )

  isSpare := method(rolls, index,
    rolls at(index) + rolls at(index + 1) == 10
  )

  spareBonus := method(rolls, index,
    rolls at(index + 2)
  )
)

describe(Bowling) do (
  it ("scores 0 for all gutter game") do (
    20 repeat ( subject hit(0) )
    score should == 0
  )

  it ("scores 20 for all ones") do (
    20 repeat ( subject hit(1) )
    subject score should == 20
  )

  it ("scores one spare") do (
    subject hit(5)
    subject hit(5)
    subject hit(3)
    17 repeat ( subject hit(0) )
    subject score should == 16
  )

  it ("scores one strike") do (
    subject hit(10)
    subject hit(4)
    subject hit(3)
    16 repeat ( subject hit(0) )
    subject score should == 24
  )

  it ("scores 300 for perfect game") do (
    12 repeat ( subject hit(10) )
    subject score should == 300
  )
)

