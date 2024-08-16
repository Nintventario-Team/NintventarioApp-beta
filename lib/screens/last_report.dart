import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget to display the last report preview.
class LastReport extends StatefulWidget {
  /// Constructor constant of the LastReport class.
  const LastReport({super.key});

  @override
  LastReportState createState() => LastReportState();
}

/// State of the LastReport widget.
class LastReportState extends State<LastReport> {
  late Future<Map<String, String>> _reportPreviewFuture;

  @override
  void initState() {
    super.initState();
    _reportPreviewFuture =
        _fetchLastReportPreview(); // Load the last report preview on screen start
  }

  Future<Map<String, String>> _fetchLastReportPreview() async {
    // Simulate the retrieval of the report information
    // In a real application, this information would be obtained from the server
    return <String, String>{
      'name': 'Inventario de Productos',
      'date': '2024-08-16',
    };
  }

  Future<void> _downloadReport() async {
    try {
      // Send a request to generate the PDF report
      final Uri urlPost =
          Uri.parse('https://servernintventario.onrender.com/upload-pdf/');
      final http.Response responsePost = await http.post(
        urlPost,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: '{}',
      );

      if (responsePost.statusCode == 200) {
        if (kDebugMode) {
          print('¡Solicitud de PDF enviada correctamente!');
        }
      } else {
        if (kDebugMode) {
          print(
              'Fallo en la solicitud de generación del PDF. Código de estado: ${responsePost.statusCode}');
        }
      }

      // Download the generated PDF report
      await downloadPdfFile();
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar el reporte: $e');
      }
    }
  }

  /// Downloads the PDF file from the server.
  Future<void> downloadPdfFile() async {
    final Uri url =
        Uri.parse('https://servernintventario.onrender.com/download-pdf/');
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir la URL $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vista Previa del Reporte',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _reportPreviewFuture,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No hay reportes disponibles.'));
          } else {
            final String name = snapshot.data!['name']!;
            final String date = snapshot.data!['date']!;

            return Center(
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text('Fecha de creación: $date'),
                  trailing: const Icon(Icons.download),
                  onTap: _downloadReport, // Descargar el reporte al hacer clic
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
