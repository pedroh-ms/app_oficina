import 'package:app_oficina/app/globals.dart';
import 'package:app_oficina/app/views/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp();
  runApp(const MainApp());
}

void setUp() {
  GetIt.I.registerSingleton<Globals>(Globals());
  GetIt.I<Globals>().url = '192.168.0.105:4000';
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
