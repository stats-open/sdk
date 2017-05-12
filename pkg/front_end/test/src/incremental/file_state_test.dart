// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:front_end/memory_file_system.dart';
import 'package:front_end/src/fasta/translate_uri.dart';
import 'package:front_end/src/incremental/file_state.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'mock_sdk.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(FileSystemStateTest);
  });
}

@reflectiveTest
class FileSystemStateTest {
  final fileSystem = new MemoryFileSystem(Uri.parse('file:///'));
  final TranslateUri uriTranslator = new TranslateUri({}, {});
  FileSystemState fsState;

  Uri _coreUri;

  void setUp() {
    Map<String, Uri> dartLibraries = createSdkFiles(fileSystem);
    uriTranslator.dartLibraries.addAll(dartLibraries);
    _coreUri = uriTranslator.dartLibraries['core'];
    expect(_coreUri, isNotNull);
    fsState = new FileSystemState(fileSystem, uriTranslator);
  }

  test_getFile() async {
    var a = writeFile('/a.dart', '');
    var b = writeFile('/b.dart', '');
    var c = writeFile('/c.dart', '');
    var d = writeFile(
        '/d.dart',
        r'''
import "a.dart";
export "b.dart";
part "c.dart";
''');

    FileState aFile = await fsState.getFile(a);
    FileState bFile = await fsState.getFile(b);
    FileState cFile = await fsState.getFile(c);
    FileState dFile = await fsState.getFile(d);

    expect(dFile.fileUri, d);
    expect(dFile.exists, isTrue);
    _assertImportedUris(dFile, [a, _coreUri]);
    expect(dFile.importedLibraries, contains(aFile));
    expect(dFile.exportedLibraries, contains(bFile));
    expect(dFile.partFiles, contains(cFile));

    expect(aFile.fileUri, a);
    expect(aFile.exists, isTrue);
    _assertImportedUris(aFile, [_coreUri]);
    expect(aFile.exportedLibraries, isEmpty);
    expect(aFile.partFiles, isEmpty);

    expect(bFile.fileUri, b);
    expect(bFile.exists, isTrue);
    _assertImportedUris(bFile, [_coreUri]);
    expect(bFile.exportedLibraries, isEmpty);
    expect(bFile.partFiles, isEmpty);
  }

  test_topologicalOrder_cycleBeforeTarget() async {
    var aUri = _writeFileDirectives('/a.dart');
    var bUri = _writeFileDirectives('/b.dart', imports: ['c.dart']);
    var cUri = _writeFileDirectives('/c.dart', imports: ['b.dart']);
    var dUri = _writeFileDirectives('/d.dart', imports: ['a.dart', 'b.dart']);

    FileState core = await fsState.getFile(_coreUri);
    FileState a = await fsState.getFile(aUri);
    FileState b = await fsState.getFile(bUri);
    FileState c = await fsState.getFile(cUri);
    FileState d = await fsState.getFile(dUri);

    List<LibraryCycle> order = d.topologicalOrder;
    expect(order, hasLength(4));
    expect(order[0].libraries, contains(core));
    expect(order[1].libraries, unorderedEquals([a]));
    expect(order[2].libraries, unorderedEquals([b, c]));
    expect(order[3].libraries, unorderedEquals([d]));
  }

  test_topologicalOrder_cycleBeforeTarget_export() async {
    var aUri = _writeFileDirectives('/a.dart');
    var bUri = _writeFileDirectives('/b.dart', exports: ['c.dart']);
    var cUri = _writeFileDirectives('/c.dart', imports: ['b.dart']);
    var dUri = _writeFileDirectives('/d.dart', imports: ['a.dart', 'b.dart']);

    FileState core = await fsState.getFile(_coreUri);
    FileState a = await fsState.getFile(aUri);
    FileState b = await fsState.getFile(bUri);
    FileState c = await fsState.getFile(cUri);
    FileState d = await fsState.getFile(dUri);

    List<LibraryCycle> order = d.topologicalOrder;
    expect(order, hasLength(4));
    expect(order[0].libraries, contains(core));
    expect(order[1].libraries, unorderedEquals([a]));
    expect(order[2].libraries, unorderedEquals([b, c]));
    expect(order[3].libraries, unorderedEquals([d]));
  }

  test_topologicalOrder_cycleWithTarget() async {
    var aUri = _writeFileDirectives('/a.dart');
    var bUri = _writeFileDirectives('/b.dart', imports: ['c.dart']);
    var cUri = _writeFileDirectives('/c.dart', imports: ['a.dart', 'b.dart']);

    FileState core = await fsState.getFile(_coreUri);
    FileState a = await fsState.getFile(aUri);
    FileState b = await fsState.getFile(bUri);
    FileState c = await fsState.getFile(cUri);

    List<LibraryCycle> order = c.topologicalOrder;
    expect(order, hasLength(3));
    expect(order[0].libraries, contains(core));
    expect(order[1].libraries, unorderedEquals([a]));
    expect(order[2].libraries, unorderedEquals([b, c]));
  }

  /// Write the given [text] of the file with the given [path] into the
  /// virtual filesystem.  Return the URI of the file.
  Uri writeFile(String path, String text) {
    Uri uri = Uri.parse('file://$path');
    fileSystem.entityForUri(uri).writeAsStringSync(text);
    return uri;
  }

  void _assertImportedUris(FileState file, List<Uri> expectedUris) {
    Iterable<Uri> importedUris = _toFileUris(file.importedLibraries);
    expect(importedUris, unorderedEquals(expectedUris));
  }

  Iterable<Uri> _toFileUris(List<FileState> files) {
    return files.map((f) => f.fileUri);
  }

  Uri _writeFileDirectives(String path,
      {List<String> imports: const [], List<String> exports: const []}) {
    return writeFile(
        path,
        '''
${imports.map((uri) => 'import "$uri";').join('\n')}
${exports.map((uri) => 'export "$uri";').join('\n')}
''');
  }
}
