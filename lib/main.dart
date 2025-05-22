import 'package:flutter/material.dart';
import 'package:frontend/features/config/router/app_route.dart';
import 'package:frontend/features/core/service/network_service.dart';
import 'package:frontend/features/data/models/appointment_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AppointmentAdapter());

  await Hive.openBox<Appointment>('appointments');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _connectivityService = ConnectivityService();
    _connectivityService.initialize(context);
  }

  // No Internet
  late ConnectivityService _connectivityService;

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
