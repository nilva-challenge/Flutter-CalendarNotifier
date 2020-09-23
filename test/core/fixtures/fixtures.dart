import 'dart:io';

String getFixture(final String path) =>
    new File('test\\fixtures\\$path').readAsStringSync();
