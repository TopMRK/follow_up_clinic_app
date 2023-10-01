part of 'internet_checker_cubit.dart';

sealed class InternetCheckerState extends Equatable {
  const InternetCheckerState();

  @override
  List<Object> get props => [];
}

final class InternetCheckerInitial extends InternetCheckerState {}

final class InternetCheckerLoading extends InternetCheckerState {}

final class InternetCheckerSuccess extends InternetCheckerState {}

final class InternetCheckerFailed extends InternetCheckerState {}
