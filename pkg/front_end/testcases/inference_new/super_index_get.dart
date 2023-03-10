// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

import 'dart:async';

T f<T>() => throw '';

class B {
  num operator [](int x) => throw '';
}

class C extends B {
  int operator [](Object x) => throw '';
  void h() {
    var /*@type=num*/ x = super /*@target=B.[]*/ [/*@typeArgs=int*/ f()];
  }
}

main() {}
