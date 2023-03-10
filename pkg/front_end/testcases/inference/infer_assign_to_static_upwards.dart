// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

int getInt() => 0;
num getNum() => 0;
double getDouble() => 0.0;

int topLevelInt = 0;
int? topLevelInt2;
num topLevelNum = 0;
num? topLevelNum2;
double topLevelDouble = 0;
double? topLevelDouble2;

void test1() {
  var /*@type=int*/ v1 = topLevelInt = getInt();

  var /*@type=int*/ v4 = topLevelInt2 ??= getInt();

  var /*@type=int*/ v7 = topLevelInt  /*@target=num.+*/+= getInt();

  var /*@type=int*/ v10 =  /*@target=num.+*/++topLevelInt;

  var /*@type=int*/ v11 =  /*@type=int*/topLevelInt   /*@target=num.+*//*@type=int*/++;
}

void test2() {
  var /*@type=int*/ v1 = topLevelNum = getInt();

  var /*@type=num*/ v2 = topLevelNum = getNum();

  var /*@type=double*/ v3 = topLevelNum = getDouble();

  var /*@type=num*/ v4 = topLevelNum2 ??= getInt();

  var /*@type=num*/ v5 = topLevelNum2 ??= getNum();

  var /*@type=num*/ v6 = topLevelNum2 ??= getDouble();

  var /*@type=num*/ v7 = topLevelNum /*@target=num.+*/ += getInt();

  var /*@type=num*/ v8 = topLevelNum /*@target=num.+*/ += getNum();

  var /*@type=double*/ v9 = topLevelNum /*@target=num.+*/ += getDouble();

  var /*@type=num*/ v10 = /*@target=num.+*/ ++topLevelNum;

  var /*@type=num*/ v11 = /*@type=num*/ topLevelNum /*@type=num*/ /*@target=num.+*/ ++;
}

void test3() {
  var /*@type=double*/ v3 = topLevelDouble = getDouble();

  var /*@type=double*/ v6 = topLevelDouble2 ??= getDouble();

  var /*@type=double*/ v7 = topLevelDouble /*@target=double.+*/ += getInt();

  var /*@type=double*/ v8 = topLevelDouble /*@target=double.+*/ += getNum();

  var /*@type=double*/ v9 = topLevelDouble /*@target=double.+*/ += getDouble();

  var /*@type=double*/ v10 = /*@target=double.+*/ ++topLevelDouble;

  var /*@type=double*/ v11 = /*@type=double*/ topLevelDouble /*@type=double*/ /*@target=double.+*/ ++;
}

main() {}
