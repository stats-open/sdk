// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

/// (backslash) uXXXX must have exactly 4 hex digits.

main() {
  var str = "Foo\u00";
  //            ^^^^
  // [analyzer] SYNTACTIC_ERROR.INVALID_UNICODE_ESCAPE_U_NO_BRACKET
  // [cfe] An escape sequence starting with '\u' must be followed by 4 hexadecimal digits.
  str = "Foo\uDEEMBar";
  //        ^^^^^
  // [analyzer] SYNTACTIC_ERROR.INVALID_UNICODE_ESCAPE_U_NO_BRACKET
  // [cfe] An escape sequence starting with '\u' must be followed by 4 hexadecimal digits.
}
