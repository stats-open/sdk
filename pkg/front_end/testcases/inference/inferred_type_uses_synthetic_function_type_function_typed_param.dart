// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

int f(int x(String y)) => 0;
String g(int x(String y)) => '';
var v = /*@typeArgs=((String) -> int) -> Object*/ [f, g];

main() {
  v;
}
