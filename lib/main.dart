import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/homepage.dart';
import 'package:todo/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Services(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
