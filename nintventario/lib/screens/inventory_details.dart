import 'package:flutter/material.dart';
import '../widgets/date_selector_widget.dart';
import 'package:flutter/services.dart';

double _fontTitleSizeVar = 25;
double _widhtBorderBox = 1.5;
double _leftPadding = 30.0;
double _rightPadding = 30.0;
double _spacingBetweenBox = 10;
double _spacingBetweenItems = 20;
double _interPaddingBox = 10;
double _radiusBorderBox = 8.0;

String _inventoryId = "99999";
String _employeeName = "Kevin Daniel Mawyin Pilozo";

void main() {
  runApp(
    const MaterialApp(
      home: InventoryDetails(),
    ),
  );
}

class InventoryDetails extends StatefulWidget {
  const InventoryDetails({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<InventoryDetails> {
  final TextEditingController _textFieldController =
      TextEditingController(text: _employeeName);
  final TextEditingController _textFieldController2 =
      TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalles del inventario",
          style: TextStyle(fontSize: _fontTitleSizeVar),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: _leftPadding, right: _rightPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _spacingBetweenItems),
            const Text("ID del inventario:"),
            SizedBox(
              height: _spacingBetweenBox,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, width: _widhtBorderBox),
                      borderRadius: BorderRadius.circular(_radiusBorderBox),
                    ),
                    padding: EdgeInsets.all(_interPaddingBox),
                    child: Text(_inventoryId),
                  ),
                ),
              ],
            ),
            SizedBox(height: _spacingBetweenItems),
            const Text("Fecha de creación: "),
            SizedBox(height: _spacingBetweenBox),
            const DateSelectorWidget(),
            SizedBox(height: _spacingBetweenItems,),
            const Text("Duración del inventariado: "),
            SizedBox(height: _spacingBetweenBox),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController2,
                    decoration: InputDecoration(
                      hintText: 'Ingrese el número de horas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_radiusBorderBox),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: _widhtBorderBox), // Define el color y el ancho del borde
                      ),
                      contentPadding: EdgeInsets.all(_interPaddingBox),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: _spacingBetweenItems),
            const Text("Encargado del Inventario: "),
            SizedBox(height: _spacingBetweenBox),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_radiusBorderBox),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: _widhtBorderBox), // Define el color y el ancho del borde
                      ),
                      contentPadding: EdgeInsets.all(_interPaddingBox),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _spacingBetweenItems),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(200, 50), 
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 25),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('CONTINUAR'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
