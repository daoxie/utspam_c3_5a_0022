import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _storageService = StorageService();
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _storageService.getCurrentUser();
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF045b4e),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF045b4e)),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF045b4e),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFb1e007),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Color(0xFF045b4e),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentUser?.fullName ?? 'User',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${_currentUser?.username ?? 'username'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF045b4e),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.badge_outlined,
                          label: 'NIK',
                          value: _currentUser?.nik ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: _currentUser?.email ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          icon: Icons.phone_outlined,
                          label: 'Phone Number',
                          value: _currentUser?.phoneNumber ?? '-',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          icon: Icons.home_outlined,
                          label: 'Address',
                          value: _currentUser?.address ?? '-',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFb1e007),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF045b4e)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF045b4e),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
