// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

class Class<T> {
  method(T o) {
    if (o is Class) {
      o.method(null);
    }
  }
}

method<T>(T o) {
  if (o is Class) {
    o.method(null);
  }
}

main() {
  new Class().method(new Class());
  method(new Class());
}
