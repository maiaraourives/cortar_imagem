import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import 'views/cortar/cortar_view.dart';
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CortarView(),
    );
  }
}

