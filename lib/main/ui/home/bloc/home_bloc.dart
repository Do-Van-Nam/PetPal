import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitialized>(_onHomeInitialized);
  }

  void _onHomeInitialized(HomeInitialized event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    // Simulate data loading
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: HomeStatus.success));
  }
}
