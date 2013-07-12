assert("Should => use matcher from matcher register",
  matcher := BaseMatcher clone 
  matcher matchForShould := true
  matcher register("useMatcherFromRegister")
  "DSL" should useMatcherFromRegister
)

assert("Should => throw if matcher is not specified",
  ex := try ( "DSL" should )
  ex error == "No matcher provided to should"
)
