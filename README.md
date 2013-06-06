IoSpec
======

IoSpec is a BDD test library for the [Io language](http://iolanguage.org/). It is very much 
inspired by the amazing [RSpec](http://rspec.info) Ruby library.

Example
-------

    describe(Bowling) do (
      it ("scores 0 for all gutter game") do (
        game := Bowling clone
        20 repeat ( game hit(0) )
        game score should == 0
      )
    )

See the `examples` directory for more examples, among which the full bowling game.

Running your specs
------------------

By default IoSpec loads all files whose name matches `*_spec.io` in the working directory. Of 
course you can tell IoSpec to load other files, or maybe a subset of them.

To run all your specs you run IoSpec without any arguments.

    $ iospec

To run specs from a different (or specific) directory you can provide the path to that directory. 
For example, if your spec files are only in the `test` directory, run:

    $ iospec test

To run files with a different pattern you have to provide that pattern. For example, to run all 
example files in the `examples` directory, run:

    $ iospec examples/*_example.io

You can provide multiple arguments. For example, to run `calculator_spec.io` and `greeting_spec.io` 
from your `spec` directory, run:

    $ iospec spec/calculator_spec.io spec/greeting_spec.io

