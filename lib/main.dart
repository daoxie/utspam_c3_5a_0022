import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarRent App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF045b4e),
          primary: const Color(0xFF045b4e),
          secondary: const Color(0xFFb1e007),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
