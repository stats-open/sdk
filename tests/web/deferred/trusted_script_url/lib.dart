// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:expect/expect.dart';

class _Thing {}

Object create() => _Thing();

void check(Object o) {
  Expect.isTrue(o is _Thing);
}
