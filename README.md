IoSpec
======

IoSpec is the [RSpec](http://rspec.info) equivalent for the [Io language](http://iolanguage.org/).

Example
-------

    describe(Bowling) do (
      it ("scores 0 for all gutter game") do (
        game := Bowling clone
        20 repeat ( game hit(0) )
        game score should == 0
      )
    )

