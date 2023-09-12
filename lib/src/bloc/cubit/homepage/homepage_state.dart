part of 'homepage_cubit.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

final class HomepageInitial extends HomepageState {}

final class HomepageLoading extends HomepageState {}

final class HomepageError extends HomepageState {
  const HomepageError(this.message);

  final String message;
}

final class HomepageSuccess extends HomepageState {
  const HomepageSuccess(this.data);

  final List data;
}
