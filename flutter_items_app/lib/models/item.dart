class Item {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String? category;
  final DateTime createdDate;
  final DateTime? updatedDate;
  final bool isActive;

  Item({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.quantity,
    this.category,
    required this.createdDate,
    this.updatedDate,
    required this.isActive,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      category: json['category'] as String?,
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate:
          json['updatedDate'] != null
              ? DateTime.parse(json['updatedDate'])
              : null,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'isActive': isActive,
    };
  }
}
