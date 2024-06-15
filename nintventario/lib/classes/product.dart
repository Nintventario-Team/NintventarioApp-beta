enum ProductState {
  checked,
  unchecked,
}

class Product {
  final String id;
  final String name;
  final int stockAnterior;
  int stockActual;
  ProductState state;

  Product({
    required this.id,
    required this.name,
    required this.stockAnterior,
    this.stockActual = 0,
    required this.state,
  });
}
