import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityCubit() : super(ConnectivityUnknown()) {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      _onConnectivityChanged(result);
    });
  }

  void _onConnectivityChanged(ConnectivityResult result) async {
    final connectivity = result;
    if (connectivity == ConnectivityResult.none) {
      emit(ConnectivityNone());
    } else if (connectivity == ConnectivityResult.wifi) {
      emit(ConnectivityWifi());
    } else if (connectivity == ConnectivityResult.mobile) {
      emit(ConnectivityMobile());
    } else {
      emit(ConnectivityNone());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
