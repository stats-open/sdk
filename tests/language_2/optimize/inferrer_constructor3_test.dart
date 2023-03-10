// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

// Regression test for dart2js that used to optimistically infer the
// wrong types for fields because of generative constructors being
// inlined.

import "package:expect/expect.dart";

class A {
  var field;
  A(this.field);
}

dynamic c = () => new List.filled(42, null)[0];

main() {
  bar();
  // Defeat type inferencing.
  new A(c());
  doIt();
  bar();
}

@pragma('vm:never-inline')
@pragma('dart2js:noInline')
doIt() {
  () => 42;
  var c = new A(null);
  Expect.throwsNoSuchMethodError(() => c.field + 42);
}

@pragma('vm:never-inline')
@pragma('dart2js:noInline')
bar() {
  () => 42;
  return inlineLevel1();
}

inlineLevel1() {
  return inlineLevel2();
}

inlineLevel2() {
  return inlineLevel3();
}

inlineLevel3() {
  return inlineLevel4();
}

inlineLevel4() {
  return new A(42);
}
