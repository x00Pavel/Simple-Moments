import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';

import 'home_service.dart';

class HomeState {
  List<Moment> moments;

  HomeState({required this.moments});
}

HomeState _reset = HomeState(moments: []);

class HomeCubit extends Cubit<HomeState> {
  HomeServiceImp homeServiceImp;

  HomeCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() => emit(HomeState(moments: state.moments));

  void resetState() => emit(_reset);

  void getMoments() {
    state.moments = demoMoments;
    _emitState();
  }
}
