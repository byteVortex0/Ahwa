import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/services/db_helper.dart';
import 'features/home/ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper.database;

  await setupInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahwa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
