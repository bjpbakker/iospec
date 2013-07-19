assert("Report#startContext => delegates to formatter",
  formatter := Mock clone shouldReceive(startContext)
  report := Report clone setFormatter(formatter)
  report startContext("context")
  formatter verify
)

assert("Report#endContext => delegates to formatter",
  formatter := Mock clone shouldReceive(endContext)
  report := Report clone setFormatter(formatter)
  report endContext
  formatter verify
)

assert("Report#pass => delegates to formatter",
  formatter := Mock clone shouldReceive(pass)
  report := Report clone setFormatter(formatter)
  report pass("spec")
  formatter verify
)

assert("Report#fail => delegates to formatter",
  formatter := Mock clone shouldReceive(fail)
  report := Report clone setFormatter(formatter)
  report fail("spec", "cause")
  formatter verify
)

assert("Report#pending => delegates to formatter",
  formatter := Mock clone shouldReceive(pending)
  report := Report clone setFormatter(formatter)
  report pending("spec")
  formatter verify
)

assert("Report#finish => dumps pending specs with formatter",
  formatter := Mock clone ignore(pending, finish) shouldReceive(dumpPending)
  report := Report clone setFormatter(formatter)
  report pending("spec")
  report finish
  formatter verify
)

assert("Report#finish => dumps failing specs with formatter",
  formatter := Mock clone ignore(fail, finish) shouldReceive(dumpFailures)
  report := Report clone setFormatter(formatter)
  report fail("spec")
  report finish
  formatter verify
)

assert("Report#finish => delegates to formatter",
  formatter := Mock clone shouldReceive(finish)
  report := Report clone setFormatter(formatter)
  report finish
  formatter verify
)
