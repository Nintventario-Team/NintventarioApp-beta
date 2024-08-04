import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

/// An enumeration representing the state of a product.
///
/// A product can be marked as [checked] or [unchecked].
enum ProductState {
  /// Indicates that the product has been checked.
  checked,

  /// Indicates that the product has not been checked.
  unchecked,
}

/// A class representing a product in the inventory.
///
/// Each product has a unique identifier ([id]), a name ([name]),
/// a previous stock ([stockAnterior]), a current stock ([stockActual]),
/// and a state ([state]).
class Product {
  /// The unique identifier of the product.
  final String id;

  /// The name of the product.
  final String name;

  /// The previous stock of the product.
  final int stockAnterior;

  /// The current stock of the product.
  ///
  /// This value may change as inventory operations are performed.
  int stockActual;

  /// The state of the product (checked or unchecked).
  ///
  /// It can be [ProductState.checked] or [ProductState.unchecked].
  ProductState state;

  /// Constructs a Product object.
  ///
  /// [id], [name], [stockAnterior], and [state] are required parameters.
  /// [stockActual] is initialized to 0 if not provided.
  Product({
    required this.id,
    required this.name,
    required this.stockAnterior,
    this.stockActual = 0,
    this.state = ProductState.unchecked, // Ensure default is unchecked
  });

  /// Creates a Product object from a JSON map.
  ///
  /// [json] is a map with product data.
  /// Returns a [Product] instance.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['codigo'] as String,
      name: json['nombre'] as String,
      stockAnterior: json['stock_inicial'] as int,
      stockActual: json['stock_final'] as int,
      state: json['state'] == 'unchecked'
          ? ProductState.unchecked
          : ProductState.checked,
    );
  }
}

/// Extension method for the Product class to convert it to a JSON-compatible map.
extension ProductJson on Product {
  /// Converts the product to a JSON-compatible map.
  ///
  /// Returns a map with product properties.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': id,
      'nombre': name,
      'stock_inicial': stockAnterior,
      'stock_final': stockActual,
      'state': state == ProductState.unchecked ? 'unchecked' : 'checked',
    };
  }
}

/// Sends the list of products to the server as a JSON object.
Future<void> saveAndUploadProductsAsJson(List<Product> products) async {
  try {
    // Convert list of Product objects to a list of JSON-compatible maps
    final List<Map<String, dynamic>> jsonList =
        products.map((Product product) => product.toJson()).toList();

    // Wrap the JSON list with a key 'json_data'
    final Map<String, dynamic> jsonDataMap = <String, dynamic>{
      'json_data': jsonList
    };

    // Encode the map to a JSON string
    final String jsonString = jsonEncode(jsonDataMap);
    if (kDebugMode) {
      print(jsonString);
    }

    // Send the JSON string to the server
    final http.Response response = await http.post(
      Uri.parse(
          'https://servernintventario.onrender.com/upload-json/'), // Adjust URL as needed
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonString,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('JSON data uploaded successfully!');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload JSON data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error saving or uploading JSON data: $e');
    }
  }

  final Uri urlPost =
      Uri.parse('https://servernintventario.onrender.com/upload-excel/');

  /// Do Post to upload Excel File
  final http.Response responsePost = await http.post(
    urlPost,
    headers: <String, String>{
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    },
    body: '{}',
  );

  if (kDebugMode) {
    print(responsePost.statusCode);
  }

  downloadExcelFile();
}

/// Download the excel of product update.
Future<void> downloadExcelFile() async {
  final Uri url =
      Uri.parse('https://servernintventario.onrender.com/download-excel/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

/// Generate the pdf file with data.
Future<void> saveAndUploadProductsAsPdf(List<Product> products) async {
  try {
    // Convert list of Product objects to a list of JSON-compatible maps
    final List<Map<String, dynamic>> jsonList =
        products.map((Product product) => product.toJson()).toList();

    // Wrap the JSON list with a key 'json_data'
    final Map<String, dynamic> jsonDataMap = <String, dynamic>{
      'json_data': jsonList
    };

    // Encode the map to a JSON string
    final String jsonString = jsonEncode(jsonDataMap);

    // Send the JSON string to the server
    final http.Response response = await http.post(
      Uri.parse('https://servernintventario.onrender.com/upload-json/'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonString,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('JSON data uploaded successfully!');
      }
    } else {
      if (kDebugMode) {
        print('Failed to upload JSON data. Status code: ${response.statusCode}');
      }
    }

    // Request PDF generation from the server
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
        print('PDF request sent successfully!');
      }
    } else {
      if (kDebugMode) {
        print(
          'Failed to request PDF generation. Status code: ${responsePost.statusCode}');
      }
    }

    if (kDebugMode) {
      print('No se llega hasta aqui?');
    }
    await downloadPdfFile();
  } catch (e) {
    if (kDebugMode) {
      print('Error saving or uploading data: $e');
    }
  }
}

/// Download the generated PDF
Future<void> downloadPdfFile() async {
  final Uri url =
      Uri.parse('https://servernintventario.onrender.com/download-excel/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
