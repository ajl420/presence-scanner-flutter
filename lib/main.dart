import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ScannerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:
          const Color.fromRGBO(20, 128, 147, 1.0)),
        primaryColor: const Color.fromRGBO(20, 128, 147, 1.0),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Pratique en flutter'),
        "/scanner": (context) => const ScannerScreen()
      },
      debugShowCheckedModeBanner: false,

    );
  }
}


