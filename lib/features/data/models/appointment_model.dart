import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 0)
class Appointment extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String age;

  @HiveField(3)
  String doctor;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  String time;

  @HiveField(6)
  int amount;

  @HiveField(7)
  String notes;

  Appointment({
    required this.name,
    required this.phone,
    required this.age,
    required this.doctor,
    required this.date,
    required this.time,
    required this.amount,
    required this.notes,
  });
}
