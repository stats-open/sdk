// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

class I {
  bool operator [](int index) => true;
}

abstract class C implements I {}

f(C c) {
  var /*@type=bool*/ x = c /*@target=I.[]*/ [0];
}

main() {}
