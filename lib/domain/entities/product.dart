class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final String creationAt;
  final String updatedAt;
  final Category category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });
}

class Category {
  final int id;
  final String name;
  final String image;
  final String creationAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });
}
