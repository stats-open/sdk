// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'issue41210_lib.dart';

class E with A, D {} // ok

class G with A, F {} // ok

main() {}
