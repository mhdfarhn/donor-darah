import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../constants/constants.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<LoadCurrentPosition>((event, emit) async {
      emit(PositionLoading());
      try {
        Position position = await AppFunction.getCurrentPosition();

        emit(PositionLoaded(position));
      } catch (e) {
        emit(PositionError(e.toString()));
      }
    });
  }
}
