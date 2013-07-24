module(iospec) do (
  module(dsl) do (
    assert("Should => use matcher from matcher register",
      matcher := iospec matchers BaseMatcher clone 
      matcher matchForShould := true
      matcher register("useMatcherFromRegister")
      "DSL" should useMatcherFromRegister
    )

    assert("Should => throws if matcher is not specified",
      ex := try ( "DSL" should )
      ex error == "No matcher provided to should"
    )

    assert("Should => throws if actual differs expected",
      ex := try ( 5 should < 4 )
      ex isKindOf(iospec matchers ExpectationNotMetError) or ex pass
    )

    assert("Should => exception has message",
      ex := try ( 5 should < 4 )
      ex error
    )

    assert("Should not => use matcher from register",
      matcher := iospec matchers BaseMatcher clone
      matcher matchForShouldNot := true
      matcher register("useMatcherFromRegister")
      "DSL" shouldNot useMatcherFromRegister
    )

    assert("Should not => use failure message for not",
      matcher := iospec matchers BaseMatcher clone
      matcher matchForShouldNot := false
      matcher failureMessageForShouldNot := "failure"
      matcher register("failWithWrongMessage")
      ex := try ( "DSL" shouldNot failWithWrongMessage )
      ex error == "failure"
    )
  )
)
