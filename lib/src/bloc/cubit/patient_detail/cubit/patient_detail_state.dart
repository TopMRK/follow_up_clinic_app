part of 'patient_detail_cubit.dart';

sealed class PatientDetailState extends Equatable {
  const PatientDetailState();

  @override
  List<Object> get props => [];
}

final class PatientDetailInitial extends PatientDetailState {}

final class PatientDetailLoading extends PatientDetailState {}

final class PatientDetailSuccess extends PatientDetailState {
  const PatientDetailSuccess(this.data);

  final List<PatientDetailModel> data;
}

final class PatientDetailError extends PatientDetailState {
  const PatientDetailError(this.message);

  final String message;
}
