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
    required this.state,
  });
}

