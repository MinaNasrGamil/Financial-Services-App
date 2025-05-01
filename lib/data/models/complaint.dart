import 'package:finance_app/constants/enums/status_enum.dart';

class Complaint {
  final String name;
  final String phone;
  final ComplaintTypeEnum type;
  final String details;

  Complaint({
    required this.name,
    required this.phone,
    required this.type,
    required this.details,
  });
}
