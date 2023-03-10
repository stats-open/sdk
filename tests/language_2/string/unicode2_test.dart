// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

/// \u{X*} should have 1-6 hex digits.

main() {
  var str = "Foo\u{}Bar";
  //            ^^^^
  // [analyzer] SYNTACTIC_ERROR.INVALID_UNICODE_ESCAPE_U_BRACKET
  // [cfe] An escape sequence starting with '\u{' must be followed by 1 to 6 hexadecimal digits followed by a '}'.
  str = "Foo\u{000000000}Bar";
  //        ^^^^^^^^^
  // [analyzer] SYNTACTIC_ERROR.INVALID_UNICODE_ESCAPE_U_BRACKET
  // [cfe] An escape sequence starting with '\u{' must be followed by 1 to 6 hexadecimal digits followed by a '}'.
  str = "Foo\u{DEAF!}Bar";
  //        ^^^^^^^^
  // [analyzer] SYNTACTIC_ERROR.INVALID_UNICODE_ESCAPE_U_BRACKET
  // [cfe] An escape sequence starting with '\u{' must be followed by 1 to 6 hexadecimal digits followed by a '}'.
}
