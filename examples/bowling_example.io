Bowling := Object clone do (
  init := method(
    newSlot("rolls", list)
  )

  hit := method(pins,
    rolls append(pins)
  )

  score := method(
    score := 0
    roll_index := 0
    10 repeat (
      if (is_strike(rolls, roll_index)) then (
        score = score + 10 + strike_bonus(rolls, roll_index)
        roll_index = roll_index + 1
      ) elseif (is_spare(rolls, roll_index)) then (
        score = score + 10 + spare_bonus(rolls, roll_index)
        roll_index = roll_index + 2
      ) else (
        score = score + rolls at(roll_index) + rolls at(roll_index + 1)
        roll_index = roll_index + 2
      )
    )
    score
  )

  is_strike := method(rolls, index,
    rolls at(index) == 10
  )

  strike_bonus := method(rolls, index,
    rolls at(index + 1) + rolls at(index + 2)
  )

  is_spare := method(rolls, index,
    rolls at(index) + rolls at(index + 1) == 10
  )

  spare_bonus := method(rolls, index,
    rolls at(index + 2)
  )
)

describe(Bowling) do (
  it ("scores 0 for all gutter game") do (
    20 repeat ( hit(0) )
    score should == 0
  )

  it ("scores 20 for all ones") do (
    20 repeat ( hit(1) )
    score should == 20
  )

  it ("scores one spare") do (
    hit(5)
    hit(5)
    hit(3)
    17 repeat ( hit(0) )
    score should == 16
  )

  it ("scores one strike") do (
    hit(10)
    hit(4)
    hit(3)
    16 repeat ( hit(0) )
    score should == 24
  )

  it ("scores 300 for perfect game") do (
    12 repeat ( hit(10) )
    score should == 300
  )
)

