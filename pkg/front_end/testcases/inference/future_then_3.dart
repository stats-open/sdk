// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

import 'dart:async';

class MyFuture<T> implements Future<T> {
  MyFuture() {}
  MyFuture.value(T x) {}
  dynamic noSuchMethod(invocation) => null;
  MyFuture<S> then<S>(FutureOr<S> f(T x), {Function? onError}) => throw '';
}

void test(MyFuture f) {
  MyFuture<int> t1 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async =>
          await new Future<int>.value(3));
  MyFuture<int> t2 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async {
    return await new Future<int>.value(3);
  });
  MyFuture<int> t3 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async => 3);
  MyFuture<int> t4 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async {
    return 3;
  });
  MyFuture<int> t5 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) =>
          new Future<int>.value(3));
  MyFuture<int> t6 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) {
    return new Future<int>.value(3);
  });
  MyFuture<int> t7 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async =>
          new Future<int>.value(3));
  MyFuture<int> t8 = f. /*@typeArgs=int*/ /*@target=MyFuture.then*/ then(
      /*@returnType=Future<int>*/ (/*@ type=dynamic */ _) async {
    return new Future<int>.value(3);
  });
}

main() {}
