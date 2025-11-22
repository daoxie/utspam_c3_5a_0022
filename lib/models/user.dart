class User {
  final String fullName;
  final String nik;
  final String email;
  final String phoneNumber;
  final String address;
  final String username;
  final String password;

  User({
    required this.fullName,
    required this.nik,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'nik': nik,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'username': username,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      nik: json['nik'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      username: json['username'],
      password: json['password'],
    );
  }
}
