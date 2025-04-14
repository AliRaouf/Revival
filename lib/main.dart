import 'package:flutter/material.dart';
import 'features/login/presentation/views/login_page.dart';

void main() {
  runApp(const RevivalApp());
}

class RevivalApp extends StatelessWidget {
  const RevivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(body: LoginPage()),
    );
  }
}

