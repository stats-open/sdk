// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const recordConstant = (42, 'Hey', foo: 'foo');

recordLiteral(x, y, z) => (x, y, bar: z);

recordFieldAccess1((int, String) rec) => rec.$0;

recordFieldAccess2(({int a, String b}) rec) => rec.a;

dynamic list = ['abc', (42, foo42: 'foo42')];

recordDynamicFieldAccess(dynamic x) => x.foo42;

main() {
  print(recordConstant);
  print(recordLiteral(1, 2, 3));
  print(recordFieldAccess1((10, 'hi')));
  print(recordFieldAccess2((a: 20, b: 'bye')));
  print(recordDynamicFieldAccess(list[1]));
}
