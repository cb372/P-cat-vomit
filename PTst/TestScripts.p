test tcOneHumanNoWhiteboard [main = OneHumanNoWhiteboard]:
  assert CatGetsFed, CatNeverVomitsOnCarpet in
    (union CatVomit, { OneHumanNoWhiteboard });

test tcTwoHumansNoWhiteboard [main = TwoHumansNoWhiteboard]:
  assert CatGetsFed, CatNeverVomitsOnCarpet in
    (union CatVomit, { TwoHumansNoWhiteboard });

test tcTwoHumansUsingWhiteboard [main = TwoHumansUsingWhiteboard]:
  assert CatGetsFed, CatNeverVomitsOnCarpet in
    (union CatVomit, { TwoHumansUsingWhiteboard });

test tcTwoHumansUsingWhiteboardWithFailure [main = TwoHumansUsingWhiteboardWithOneFailure]:
  assert CatGetsFed, CatNeverVomitsOnCarpet in
    (union CatVomit, { TwoHumansUsingWhiteboardWithOneFailure });