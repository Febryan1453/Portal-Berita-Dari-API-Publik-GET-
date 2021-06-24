import 'package:flutter/material.dart';
import 'package:portal_berita/portal_berita.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PortalBeritaApp(),
    );
  }
}
