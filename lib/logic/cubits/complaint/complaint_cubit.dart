import 'package:equatable/equatable.dart';
import 'package:finance_app/constants/enums/status_enum.dart';
import 'package:finance_app/data/models/complaint.dart';
import 'package:finance_app/data/repositories/complaint_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ComplaintRepository repository;
  ComplaintCubit(this.repository) : super(ComplaintState.initial());

  Future<void> submitComplaint(Complaint complaint) async {
    emit(state.copyWith(status: StatusEnum.loading));
    try {
      await repository.submitComplaint(complaint);
      emit(state.copyWith(status: StatusEnum.success));
    } catch (e) {
      emit(
          state.copyWith(status: StatusEnum.error, errorMessage: e.toString()));
    }
  }
}
