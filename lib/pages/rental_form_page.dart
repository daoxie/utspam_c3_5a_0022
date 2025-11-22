import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/car.dart';
import '../models/rental.dart';
import '../services/storage_service.dart';
import 'rental_history_page.dart';

class RentalFormPage extends StatefulWidget {
  final Car car;

  const RentalFormPage({super.key, required this.car});

  @override
  State<RentalFormPage> createState() => _RentalFormPageState();
}

class _RentalFormPageState extends State<RentalFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _storageService = StorageService();

  final _renterNameController = TextEditingController();
  final _rentalDaysController = TextEditingController();
  DateTime? _startDate;

  bool _isLoading = false;

  @override
  void dispose() {
    _renterNameController.dispose();
    _rentalDaysController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF045b4e),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF045b4e),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _submitRental() async {
    if (_formKey.currentState!.validate() && _startDate != null) {
      setState(() {
        _isLoading = true;
      });

      final rentalDays = int.parse(_rentalDaysController.text);
      final totalCost = widget.car.pricePerDay * rentalDays;

      final rental = Rental(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        car: widget.car,
        renterName: _renterNameController.text,
        rentalDays: rentalDays,
        startDate: _startDate!,
        totalCost: totalCost,
        status: 'active',
      );

      await _storageService.saveRental(rental);

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rental created successfully'),
            backgroundColor: Color(0xFF045b4e),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RentalHistoryPage()),
        );
      }
    } else if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select start date'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF045b4e),
        foregroundColor: Colors.white,
        title: const Text('Rent Car'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFF045b4e),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.car.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.directions_car, size: 80),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.car.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFb1e007),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.car.type,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF045b4e),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Rp ${widget.car.pricePerDay.toStringAsFixed(0)} / day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb1e007),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rental Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF045b4e),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _renterNameController,
                      decoration: InputDecoration(
                        labelText: 'Renter Name',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF045b4e),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF045b4e),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Renter name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _rentalDaysController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Rental Days',
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF045b4e),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF045b4e),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Rental days is required';
                        }
                        final days = int.tryParse(value);
                        if (days == null || days <= 0) {
                          return 'Please enter a valid positive number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Color(0xFF045b4e),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _startDate == null
                                    ? 'Select Start Date'
                                    : DateFormat(
                                        'dd MMM yyyy',
                                      ).format(_startDate!),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _startDate == null
                                      ? Colors.grey
                                      : const Color(0xFF045b4e),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_rentalDaysController.text.isNotEmpty &&
                        int.tryParse(_rentalDaysController.text) != null) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFb1e007),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Cost',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF045b4e),
                              ),
                            ),
                            Text(
                              'Rp ${(widget.car.pricePerDay * int.parse(_rentalDaysController.text)).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF045b4e),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitRental,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF045b4e),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Confirm Rental',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
