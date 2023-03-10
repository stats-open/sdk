// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

/*@testedFeatures=inference*/
library test;

class A {
  final String foo;

  A(this.foo);

  bool operator ==(Object other) =>
      other is A && /*@promotedType=A**/ other
              . /*@target=A.foo*/ foo /*@target=String.==*/ ==
          this. /*@target=A.foo*/ foo && /*@promotedType=A**/ other
              . /*@target=A.foo*/ foo /*@target=String.==*/ ==
          this. /*@target=A.foo*/ foo;
}

main() {
  print(new A("hello") /*@target=A.==*/ == new A("hello"));
}
