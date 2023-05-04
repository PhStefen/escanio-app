class Product {
  Product({required this.id, required this.name, required this.price});

  Product.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          price: json['price']! as num,
        );

  final String id;
  final String name;
  final num price;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
