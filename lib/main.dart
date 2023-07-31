import 'package:flutter/material.dart';
import 'package:flutter_social_media/app/app.dart';
import 'package:loggy/loggy.dart';

void main() {
  /// Initialize logger
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
  );

  runApp(const App());
}
