import 'package:flutter/material.dart';
import 'package:frontend/features/config/theme/app_theme.dart';
import 'package:frontend/features/data/data/doctorlist_data.dart';
import 'package:frontend/features/presentation/ui/details/bookings_list.dart';
import 'package:frontend/features/presentation/ui/details/doctor_details.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark
            ? AppTheme.darkTheme.primaryColor
            : AppTheme.lightTheme.primaryColor;

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    const Icon(Icons.exit_to_app, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Text(
                      'Exit App?',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                content: Text(
                  'Are you sure you want to close the app?',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No', style: GoogleFonts.poppins()),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Yes',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 8,
          shadowColor: Colors.black26,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/icon.webp'),
              radius: 20,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Find Your Doctor',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.event_available_rounded,
                size: 28,
                color: Colors.white,
              ),
              tooltip: 'My Bookings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookingListScreen()),
                );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Material(
                color: Colors.white,
                elevation: 6,
                shadowColor: Colors.black12,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorDetailScreen(service: service),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            Colors
                                .grey
                                .shade300, // Change to your preferred border color
                        width: 2, // Thickness of the border
                      ),
                    ),

                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            service.iconUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                service.speciality,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    service.duration,
                                    style: GoogleFonts.poppins(fontSize: 13),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.attach_money,
                                    size: 16,
                                    color: Colors.green[700],
                                  ),
                                  Text(
                                    '${service.fees}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
