// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class A {
  num field = 0;
}

class B {
  covariant num field = 0;
}

class C extends A implements B {
  num field = 0;
}

main() {}
