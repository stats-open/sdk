// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Testing GC, issue 1469.

// @dart = 2.9

main() {
  var div;
  for (int i = 0; i < 200; ++i) {
    List l = new List<dynamic>.filled(1000000, null);
    var m = 2;
    div = (_) {
      var b = l; // Was causing OutOfMemory.
    };
    var lSmall = new List<dynamic>.filled(3, null);
    // Circular reference between new and old gen objects.
    lSmall[0] = l;
    l[0] = lSmall;
  }
}
