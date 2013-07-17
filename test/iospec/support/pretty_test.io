assert("Pretty#words => returns sequence for sequence separated by spaces",
  Pretty words("two words") == "two words"
)

assert("Pretty#words => returns lowercase sequence for single word sequence",
  Pretty words ("Two") == "two"
)

assert("Pretty#words => returns two words for CamelCase sequence",
  Pretty words("CamelCase") == "camel case"
)

assert("Pretty#words => returns all lower case for all caps sequence",
  Pretty words("HTML") == "html"
)

assert("Pretty#indentLines => gets empty seq for nil",
  Pretty indentLines(nil) == ""
)

assert("Pretty#indentLines => indents single line",
  Pretty indentLines("line", "  ") == "  line"
)

assert("Pretty#indentLines => indents multiple lines",
  Pretty indentLines("line-1\nline-2", "  ") == "  line-1\n  line-2"
)
