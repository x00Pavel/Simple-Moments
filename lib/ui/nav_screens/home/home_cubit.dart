import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_service.dart';

class HomeState {
  HomeState();
}

HomeState _reset = HomeState();

class HomeCubit extends Cubit<HomeState> {
  HomeServiceImp homeServiceImp;

  HomeCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() => emit(HomeState());

  void resetState() => emit(_reset);

  void showSalesPopUp() {

  }
}
