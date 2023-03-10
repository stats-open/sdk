// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

class Foo {
  const Foo(List<String> l);
}

void test() {
  void f(@Foo(/*@typeArgs=String*/ const []) /*@ type=dynamic */ x) {}
  var /*@type=(dynamic) -> Null*/ x = /*@ returnType=Null */ (@Foo(/*@typeArgs=String*/ const []) /*@ type=dynamic */
      x) {};
}

main() {}
