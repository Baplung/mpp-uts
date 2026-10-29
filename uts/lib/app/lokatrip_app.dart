import 'package:flutter/material.dart';

import '../screens/main_shell.dart';

class LokaTripApp extends StatelessWidget {
  const LokaTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LokaTrip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B46E8),
          primary: const Color(0xFF5B46E8),
          surface: const Color(0xFFF9F9FF),
        ),
        fontFamily: 'Segoe UI',
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}
