import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';

import 'home_service.dart';

class HomeState {
  List<Moment> moments;
  bool isLoading;

  HomeState({required this.moments, required this.isLoading});
}

HomeState _reset = HomeState(moments: [], isLoading: false);

class HomeCubit extends Cubit<HomeState> {
  HomeServiceImp homeServiceImp;

  HomeCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() =>
      emit(HomeState(moments: state.moments, isLoading: state.isLoading));

  void resetState() => emit(_reset);

  void getMoments() {
    state.isLoading = true;
    _emitState();
    Future.delayed(const Duration(seconds: 5), () {
      state.isLoading = false;
      state.moments = demoMoments;
      _emitState();
    });
  }
}
