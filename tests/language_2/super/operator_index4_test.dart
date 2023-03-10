// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

// Test for operator[] resolved in the super class.

import "package:expect/expect.dart";

class A {
  var indexField = new List<int>.filled(2, null);
  operator [](index) => indexField[index];
}

class B extends A {
  operator []=(index, value) {
    indexField[index] = value;
  }
}

class C extends B {
  test() {
    Expect.equals(42, super[0] = 42);
    Expect.equals(42, super[0]);
    Expect.equals(43, super[0] += 1);
    Expect.equals(43, super[0]);
    Expect.equals(43, super[0]++);
    Expect.equals(44, super[0]);

    Expect.equals(2, super[0] = 2);
    Expect.equals(2, super[0]);
    Expect.equals(3, super[0] += 1);
    Expect.equals(3, super[0]);
    Expect.equals(3, super[0]++);
    Expect.equals(4, super[0]);
  }
}

main() {
  new C().test();
}
