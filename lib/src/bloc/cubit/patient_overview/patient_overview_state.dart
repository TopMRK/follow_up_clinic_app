part of 'patient_overview_cubit.dart';

sealed class PatientOverviewState extends Equatable {
  const PatientOverviewState();

  @override
  List<Object> get props => [];
}

final class PatientOverviewInitial extends PatientOverviewState {}

final class PatientOverviewLoading extends PatientOverviewState {}

final class PatientOverviewSuccess extends PatientOverviewState {
  const PatientOverviewSuccess(this.data);

  final List<PatientOverviewModel> data;
}

final class PatientOverviewError extends PatientOverviewState {
  const PatientOverviewError(this.message);

  final String message;
}
