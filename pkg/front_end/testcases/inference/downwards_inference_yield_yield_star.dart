// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

import 'dart:async';

abstract class MyStream<T> extends Stream<T> {
  factory MyStream() => throw '';
}

Stream<List<int>> foo() async* {
  yield /*@typeArgs=int*/ [];
  yield /*error:YIELD_OF_INVALID_TYPE*/ new /*@ typeArgs=dynamic */ MyStream();
  yield* /*error:YIELD_OF_INVALID_TYPE*/ /*@typeArgs=dynamic*/ [];
  yield* new /*@typeArgs=List<int>*/ MyStream();
}

Iterable<Map<int, int>> bar() sync* {
  yield new /*@typeArgs=int, int*/ Map();
  yield /*error:YIELD_OF_INVALID_TYPE*/ /*@typeArgs=dynamic*/ [];
  yield* /*error:YIELD_OF_INVALID_TYPE*/ new /*@ typeArgs=dynamic, dynamic */ Map();
  yield* /*@typeArgs=Map<int, int>*/ [];
}

main() {}
