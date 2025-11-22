import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/rental.dart';

class StorageService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'currentUser';
  static const String _rentalsKey = 'rentals';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getAllUsers();
    users.add(user);
    final usersJson = users.map((u) => u.toJson()).toList();
    await prefs.setString(_usersKey, jsonEncode(usersJson));
  }

  Future<List<User>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString(_usersKey);
    if (usersString == null) return [];
    final List<dynamic> usersList = jsonDecode(usersString);
    return usersList.map((json) => User.fromJson(json)).toList();
  }

  Future<User?> login(String usernameOrNik, String password) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere(
        (user) =>
            (user.username == usernameOrNik || user.nik == usernameOrNik) &&
            user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> setCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_currentUserKey);
    if (userString == null) return null;
    return User.fromJson(jsonDecode(userString));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<void> saveRental(Rental rental) async {
    final prefs = await SharedPreferences.getInstance();
    final rentals = await getAllRentals();
    rentals.add(rental);
    final rentalsJson = rentals.map((r) => r.toJson()).toList();
    await prefs.setString(_rentalsKey, jsonEncode(rentalsJson));
  }

  Future<List<Rental>> getAllRentals() async {
    final prefs = await SharedPreferences.getInstance();
    final rentalsString = prefs.getString(_rentalsKey);
    if (rentalsString == null) return [];
    final List<dynamic> rentalsList = jsonDecode(rentalsString);
    return rentalsList.map((json) => Rental.fromJson(json)).toList();
  }

  Future<void> updateRental(Rental updatedRental) async {
    final prefs = await SharedPreferences.getInstance();
    final rentals = await getAllRentals();
    final index = rentals.indexWhere((r) => r.id == updatedRental.id);
    if (index != -1) {
      rentals[index] = updatedRental;
      final rentalsJson = rentals.map((r) => r.toJson()).toList();
      await prefs.setString(_rentalsKey, jsonEncode(rentalsJson));
    }
  }
}
