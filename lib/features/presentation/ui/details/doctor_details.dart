import 'package:flutter/material.dart';
import 'package:frontend/features/config/theme/color_constants.dart';
import 'package:frontend/features/data/models/doctorlist_model.dart';
import 'package:frontend/features/presentation/widgets/booking_form.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const DoctorDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          service.name,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Doctor Image
            Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(service.iconUrl),
                  fit: BoxFit.contain,
                ),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.black.withOpacity(0.1),
                  //   blurRadius: 10,
                  //   offset: const Offset(0, 5),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Speciality
            Text(
              service.speciality,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    service.status == 'Available'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                service.status,
                style: GoogleFonts.poppins(
                  color:
                      service.status == 'Available' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Description
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About Doctor',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // Fee and Duration
            Row(
              children: [
                _InfoBox(
                  icon: Icons.currency_rupee,
                  title: 'Fees',
                  value: '${service.fees}',
                  color: Colors.blue,
                ),
                const SizedBox(width: 16),
                _InfoBox(
                  icon: Icons.access_time,
                  title: 'Duration',
                  value: service.duration,
                  color: Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BookingFormScreen(
                            doctorName: service.name,
                            amount: service.fees.toInt(),
                          ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.032,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
