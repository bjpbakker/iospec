assert("Stats => initial passed count is zero",
  stats := Stats clone
  stats passed == 0
)

assert("Stats => counts passed examples",
  stats := Stats clone
  stats inc(passed)
  stats passed == 1
)

assert("Stats => initial failed count is zero",
  stats := Stats clone
  stats failed == 0
)

assert("Stats => counts failed examples",
  stats := Stats clone
  stats inc(failed)
  stats failed == 1
)

assert("Stats => initial pending count is zero",
  stats := Stats clone
  stats pending == 0
)

assert("Stats => counts pending examples",
  stats := Stats clone
  stats inc(pending)
  stats pending == 1
)

assert("Stats => counts total number of examples",
  stats := Stats clone
  stats inc(passed) inc(passed)
  stats inc(failed)
  stats inc(pending) inc(pending) inc(pending)
  stats total == 6
)

assert("Stats => all examples are passed as there are no failed one",
  stats := Stats clone
  stats inc(passed) inc(pending)
  stats allPassed == true
)

assert("Stats => not all examples are passed as there is a failed one",
  stats := Stats clone
  stats inc(passed) inc(failed)
  stats allPassed == false
)
