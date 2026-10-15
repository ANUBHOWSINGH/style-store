// domain entity. It represents a product independently of JSON or Flutter UI.
class ProductEntity {
  final String id;
  final String name;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
