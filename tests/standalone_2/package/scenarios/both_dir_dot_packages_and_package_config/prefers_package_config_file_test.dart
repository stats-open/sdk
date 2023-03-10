// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

// Packages=none

library prefers_package_config_file_test;

import 'package:foo/foo.dart' as foo;

main() {
  if (foo.bar != 'good') {
    throw new Exception('package "foo" was not resolved correctly');
  }
}
