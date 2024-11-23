// chemin : frontend/lib/models/item.dart
class Item {
  final String id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  // Convertir un objet Item en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Convertir un JSON en objet Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
