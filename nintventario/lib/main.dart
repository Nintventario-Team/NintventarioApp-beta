import 'package:flutter/material.dart';
import 'widgets/tab_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //button to debug
      home: Scaffold(
        appBar: AppBar(title: const Text("NINTVENTARIO"),),
        body: const CustomTabBar(),
      ),
    );


  }



}
