import 'package:nintventario/classes/product.dart';

/// Represents the state of a draft.
enum DraftState {
  /// Completed state of an inventory
  completed,
  /// UnCompleted state of an inventory
  notCompleted,
}

/// A class representing a draft.
///
/// A draft contains information about a document being created or modified.
class Draft {
  /// The unique identifier of the draft.
  final String id;

  /// The name of the employee working on the draft.
  final String employee;

  /// The estimated duration to complete the draft.
  final String duration;

  /// The creation date of the draft.
  final String creationDate;

  /// The state of the draft.
  final DraftState state;

  /// The list of products in the draft.
  final List<Product> products;

  /// Constructs a Draft object.
  ///
  /// [id], [employee], [duration], [creationDate], [state], and [products] are required parameters.
  Draft({
    required this.id,
    required this.employee,
    required this.duration,
    required this.creationDate,
    required this.state,
    required this.products,
  });
}