module(iospec) do (
  module(support) do (
    Pretty := Object clone do (
      words := method(seq,
        regex := Regex with("[A-Z]+")
        words := regex matchesIn(seq) replace(m, " " .. m string asLowercase)
        words strip
      )

      indentLines := method(seq, prefix,
        if (seq == nil,
          "",
          seq split("\n") map(prependSeq(prefix)) join("\n"))
      )
    )
  )
)
