// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

int? nullableInt = 0;

class A implements B {
  var x;
}

class B {
  var x = nullableInt;
}

main() {}
