import 'car.dart';

class Rental {
  final String id;
  final Car car;
  final String renterName;
  final int rentalDays;
  final DateTime startDate;
  final double totalCost;
  String status;

  Rental({
    required this.id,
    required this.car,
    required this.renterName,
    required this.rentalDays,
    required this.startDate,
    required this.totalCost,
    this.status = 'active',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': car.toJson(),
      'renterName': renterName,
      'rentalDays': rentalDays,
      'startDate': startDate.toIso8601String(),
      'totalCost': totalCost,
      'status': status,
    };
  }

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      car: Car.fromJson(json['car']),
      renterName: json['renterName'],
      rentalDays: json['rentalDays'],
      startDate: DateTime.parse(json['startDate']),
      totalCost: json['totalCost'].toDouble(),
      status: json['status'],
    );
  }
}
