// lib/logic/cubits/complaint_state.dart
part of 'complaint_cubit.dart';

class ComplaintState extends Equatable {
  final StatusEnum status;
  final String errorMessage;

  const ComplaintState({
    required this.status,
    required this.errorMessage,
  });

  factory ComplaintState.initial() {
    return const ComplaintState(
      status: StatusEnum.initial,
      errorMessage: '',
    );
  }

  ComplaintState copyWith({
    StatusEnum? status,
    String? errorMessage,
  }) {
    return ComplaintState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
