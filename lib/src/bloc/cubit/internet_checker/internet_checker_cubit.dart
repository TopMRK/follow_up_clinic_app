import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_checker_state.dart';

class InternetCheckerCubit extends Cubit<InternetCheckerState> {
  InternetCheckerCubit() : super(InternetCheckerInitial());

  void internetChecking() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      emit(InternetCheckerSuccess());
    } else {
      emit(InternetCheckerFailed());
    }
  }
}
