class cart {
  final String name;
  final String id;
  cart({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
  factory cart.fromJson(Map<String, dynamic> map) {
    return cart(
      id: map['resID'] ,
      name: map['name'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Herb(id: $id, name: $name)';
  }
}