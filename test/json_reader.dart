import 'dart:io';

String readJson(String name) => File('test/$name').readAsStringSync();
