// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

// Test library uri for a library read as a package .

library MirrorsTest;

import 'dart:mirrors';
import 'package:args/args.dart';
import 'package:async_helper/async_minitest.dart';

testLibraryUri(var value, Uri expectedUri) {
  var valueMirror = reflect(value);
  ClassMirror valueClass = valueMirror.type;
  LibraryMirror valueLibrary = valueClass.owner as LibraryMirror;
  Uri uri = valueLibrary.uri;
  if (!uri.isScheme("https") ||
      uri.host != "dartlang.org" ||
      uri.path != "/dart2js-stripped-uri") {
    expect(uri, equals(expectedUri));
  }
}

main() {
  var mirrors = currentMirrorSystem();
  test("Test package library uri", () {
    testLibraryUri(
        new ArgParser(), Uri.parse('package:args/src/arg_parser.dart'));
  });
}
