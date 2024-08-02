import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nintventario/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nintventario/classes/product.dart';
import 'package:uuid/uuid.dart';

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

  /// Observations related to the draft.
  final String observations;

  /// Constructor for the Draft class.
  Draft({
    String? id,
    String? employee,
    String? duration,
    String? creationDate,
    DraftState? state,
    List<Product>? products,
    String? observations,
  })  : id = id ?? _generateDefaultId(),
        employee = employee ?? 'Especifica tu nombre',
        duration = duration ?? '0',
        creationDate = creationDate ?? DateTime.now().toIso8601String(),
        state = state ?? DraftState.notCompleted,
        products = products ?? <Product>[],
        observations = observations ?? '';

  /// Generates a default unique ID for the draft.
  static String _generateDefaultId() {
    loadProducts();
    const Uuid uuid = Uuid();
    return uuid.v1(); // Generates a random UUID
  }

  /// Saves or updates the draft in persistent storage.
  ///
  /// This method encodes the draft to JSON and saves it to SharedPreferences.
  Future<void> saveDraft() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> draftsList = prefs.getStringList('drafts') ?? <String>[];

    // Find index of existing draft with the same ID
    final int existingDraftIndex = draftsList.indexWhere((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return draftJson['id'] == id;
    });

    if (existingDraftIndex != -1) {
      // Update existing draft
      draftsList[existingDraftIndex] = jsonEncode(toJson());
    } else {
      // Add new draft
      draftsList.add(jsonEncode(toJson()));
    }

    await prefs.setStringList('drafts', draftsList);
  }

  /// Converts the draft to a JSON-encodable map.
  ///
  /// Returns a map with draft properties.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'employee': employee,
      'duration': duration,
      'creationDate': creationDate,
      'state': state.index,
      'products': products.map((Product p) => p.toJson()).toList(),
      'observations': observations,
    };
  }

  /// Loads drafts from persistent storage.
  ///
  /// Returns a list of [Draft] objects.
  /// Throws an [Exception] if there's an error decoding the JSON data.
  static Future<List<Draft>> loadDrafts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> draftsList = prefs.getStringList('drafts') ?? <String>[];
    return draftsList.map((String draftStr) {
      final Map<String, dynamic> draftJson = jsonDecode(draftStr);
      return Draft(
        id: draftJson['id'],
        employee: draftJson['employee'],
        duration: draftJson['duration'],
        creationDate: draftJson['creationDate'],
        state: DraftState.values[draftJson['state']],
        products: (draftJson['products'] as List<dynamic>).map((dynamic p) => Product.fromJson(p)).toList(),
        observations: draftJson['observations'],
      );
    }).toList();
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
    globalObservations = observations;
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
