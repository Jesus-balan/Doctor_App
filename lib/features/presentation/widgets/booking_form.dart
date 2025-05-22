import 'package:flutter/material.dart';
import 'package:frontend/features/config/theme/color_constants.dart';
import 'package:frontend/features/data/models/appointment_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class BookingFormScreen extends StatefulWidget {
  final String doctorName;
  final int amount;

  const BookingFormScreen({
    super.key,
    required this.doctorName,
    required this.amount,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  final ageController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

// inside _submitForm():

void _submitForm() async {
  if (_formKey.currentState!.validate() &&
      selectedDate != null &&
      selectedTime != null) {
    final appointment = Appointment(
      name: _nameController.text,
      phone: _phoneController.text,
      age: ageController.text,
      doctor: widget.doctorName,
      date: selectedDate!,
      time: selectedTime!.format(context),
      amount: widget.amount,
      notes: _notesController.text,
    );

    final box = Hive.box<Appointment>('appointments');
    await box.add(appointment);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor:  Colors.green,
        content: Text('Appointment successfully booked!')),
    );

    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please complete all required fields')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Patient Name", _nameController),
              _buildTextField("Phone Number", _phoneController,
                  keyboardType: TextInputType.phone),
              _buildTextField("Age", ageController,
                  keyboardType: TextInputType.phone),
              
              _buildTextField("Problem Description", _notesController, maxLines: 3),
               _buildDateTimePicker(context),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Consultation Fee: ₹${widget.amount}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Confirm Appointment',style: TextStyle(
                    color: Colors.white
                  ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

   Widget _buildDateTimePicker(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      Text(
        'Select Date & Time',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          // Date Picker
          Expanded(
            child: InkWell(
              onTap: () => _pickDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'Pick Date',
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedDate != null ? Colors.black : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Time Picker
          Expanded(
            child: InkWell(
              onTap: () => _pickTime(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : 'Pick Time',
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedTime != null ? Colors.black : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
}
