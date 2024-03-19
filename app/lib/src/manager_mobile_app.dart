import 'package:manager_mobile_app/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class ManagerMobileApp extends StatelessWidget {
  const ManagerMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
