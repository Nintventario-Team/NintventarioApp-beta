// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

String local = "La entrada a la 8";


void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              const SizedBox(height: 20),
              const Center(child: Text("HOME", style: TextStyle(fontSize: 40),)),
              const SizedBox(height: 10),
              Text("Bienvenido a $local"),
              const SizedBox(height: 20,)
            ],
            ),
          toolbarHeight: 200,
        ),
        body: GridView.count(
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          children: const [
            NewInventoryWidget(),
            HistorialWidget(),
            SettingsWidget(),
            ExitWidget()
          ],
        ),
      ),
    );
  }

}

class NewInventoryWidget extends StatelessWidget{
  const NewInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Crear Inventario", style:TextStyle(fontSize: 18)))),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Center(child: IconButton(
              onPressed: () {
                //cuando se presiona
                print("XD");
               },
              icon: const Icon(Icons.edit_document, size: 70,), 
            ))
            
          ],
        ),
      )
    );
  }
}


class HistorialWidget extends StatelessWidget{

  const HistorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Historial", style:TextStyle(fontSize: 18)))),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Center(child: IconButton(
              onPressed: () {
                //cuando se presiona
                print("XD");
               },
              icon: const Icon(Icons.history, size: 70,), 
            ))
            
          ],
        ),
      )
    );
  }
}

class SettingsWidget extends StatelessWidget{

  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Ajustes", style:TextStyle(fontSize: 18)))),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Center(child: IconButton(
              onPressed: () {
                //cuando se presiona
                print("XD");
               },
              icon: const Icon(Icons.settings, size: 70,), 
            ))
            
          ],
        ),
      )
    );
  }
}

class ExitWidget extends StatelessWidget{

  const ExitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Salir", style:TextStyle(fontSize: 18)))),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Center(child: IconButton(
              onPressed: () {
                //cuando se presiona
                print("XD");
               },
              icon: const Icon(Icons.exit_to_app, size: 70,), 
            ))
            
          ],
        ),
      )
    );
  }
}
