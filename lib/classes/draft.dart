import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nintventario/classes/product.dart';
import 'package:nintventario/screens/home.dart';

/// Enum to represent the state of a draft.
enum DraftState {
  /// Indicates that the draft is completed.
  completed, 
  /// Indicates that the draft is not yet completed.
  notCompleted,
}

/// A class representing a draft.
class Draft {
  /// Unique identifier for the draft.
  final String id; 
  /// Name of the employee associated with the draft.
  final String employee;
  /// Duration for which the draft is valid.
  final String duration; 
  /// Date when the draft was created.
  final String creationDate; 
  /// Current state of the draft.
  final DraftState state; 
  /// List of products associated with the draft.
  final List<Product> products; 

  /// Default Draft.
  Draft({
    String? id,
    String? employee,
    String? duration,
    String? creationDate,
    DraftState? state,
    List<Product>? products,
  })  : id = id ?? _generateDefaultId(),
        employee = employee ?? 'Specify your name',
        duration = duration ?? '0',
        creationDate = creationDate ?? DateTime.now().toIso8601String(),
        state = state ?? DraftState.notCompleted,
        products = products ?? <Product>[];

  /// Generates a default unique ID for the draft.
  static String _generateDefaultId() {
    loadProducts();
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Updates global variables based on the draft's data.
  /// This method adds the draft to global drafts, updates the global products list,
  /// and sets the global employee name and creation date.
  void updateGlobalVariables() {
    inventoryId = id;
    globalTime = duration;
    globalDrafts.add(this);
    globalProducts = List<Product>.from(products);
    globalEmployeeName = employee;
    globalDate = creationDate;
  }

  /// Loads the list of products from a JSON file.
  ///
  /// Returns a list of [Product] objects.
  /// Throws an [Exception] if there's an error loading the JSON data.
  static Future<List<Product>> loadProducts() async {
    try {
      final String response = await rootBundle.loadString('src/files/inventario.json');
      final List<dynamic> data = jsonDecode(response);
      globalProducts = data.map((dynamic product) {
        return Product(
          id: product['codigo'],
          name: product['nombre'],
          stockAnterior: product['stock'],
          state: ProductState.unchecked,
        );
      }).toList();
      return globalProducts;
    } catch (e) {
      throw Exception('Error loading JSON: $e');
    }
  }
}
