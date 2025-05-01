// test/complaint_cubit_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/data/models/complaint.dart';
import 'package:finance_app/data/repositories/complaint_repository.dart';
import 'package:finance_app/logic/cubits/complaint/complaint_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ComplaintCubit', () {
    late ComplaintCubit complaintCubit;

    setUp(() {
      complaintCubit = ComplaintCubit(ComplaintRepository());
    });

    final testComplaint = Complaint(
      name: 'Test',
      phone: '1234567',
      type: ComplaintTypeEnum.service,
      details: 'Details',
    );

    blocTest<ComplaintCubit, ComplaintState>(
      'emits [loading, success] when submitComplaint succeeds',
      build: () => complaintCubit,
      act: (c) => c.submitComplaint(testComplaint),
      expect: () => [
        complaintCubit.state.copyWith(status: StatusEnum.loading),
        complaintCubit.state.copyWith(status: StatusEnum.success),
      ],
    );
  });
}
