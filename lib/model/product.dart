class Product {
  final String id;
  final String title;
  final String description;
  final String status;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.status});

  factory Product.fromJson(Map map) {
    return Product(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        status: map['status']);
  }
}
