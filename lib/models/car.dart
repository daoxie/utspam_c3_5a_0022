class Car {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final double pricePerDay;

  Car({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.pricePerDay,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'imageUrl': imageUrl,
      'pricePerDay': pricePerDay,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['imageUrl'],
      pricePerDay: json['pricePerDay'].toDouble(),
    );
  }
}
