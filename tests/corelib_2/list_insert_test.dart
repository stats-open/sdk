// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

import 'package:expect/expect.dart';
import 'dart:collection';

class MyList extends ListBase {
  List list;
  MyList(this.list);

  get length => list.length;
  set length(val) {
    list.length = val;
  }

  operator [](index) => list[index];
  operator []=(index, val) => list[index] = val;

  String toString() => "[" + join(", ") + "]";
}

// l1 must be a modifiable list with 5 elements from 0 to 4.
void testModifiableList(l1) {
  // Index must be integer and in range.
  Expect.throwsRangeError(() => l1.insert(-1, 5), "negative");
  Expect.throwsRangeError(() => l1.insert(6, 5), "too large");
  Expect.throws(() => l1.insert(null, 5));
  Expect.throws(() => l1.insert("1", 5));
  Expect.throws(() => l1.insert(1.5, 5));

  l1.insert(5, 5);
  Expect.equals(6, l1.length);
  Expect.equals(5, l1[5]);
  Expect.equals("[0, 1, 2, 3, 4, 5]", l1.toString());

  l1.insert(0, -1);
  Expect.equals(7, l1.length);
  Expect.equals(-1, l1[0]);
  Expect.equals("[-1, 0, 1, 2, 3, 4, 5]", l1.toString());
}

void main() {
  // Normal modifiable list.
  testModifiableList([0, 1, 2, 3, 4]);
  testModifiableList(new MyList([0, 1, 2, 3, 4]));

  // Fixed size list.
  var l2 = new List<dynamic>.filled(5, null);
  for (var i = 0; i < 5; i++) l2[i] = i;
  Expect.throwsUnsupportedError(() => l2.insert(2, 5), "fixed-length");

  // Unmodifiable list.
  var l3 = const [0, 1, 2, 3, 4];
  Expect.throwsUnsupportedError(() => l3.insert(2, 5), "unmodifiable");

  // Empty list is not special.
  var l4 = [];
  l4.insert(0, 499);
  Expect.equals(1, l4.length);
  Expect.equals(499, l4[0]);
}
