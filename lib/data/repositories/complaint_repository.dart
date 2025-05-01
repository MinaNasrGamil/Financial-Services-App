import 'package:finance_app/constants/AppConstants.dart';
import 'package:finance_app/data/models/complaint.dart';

class ComplaintRepository {
  Future<void> submitComplaint(Complaint complaint) async {
    await Future.delayed(AppConstants.apiDelay);
    // simulate success or throw Exception('Error message');
  }
}
