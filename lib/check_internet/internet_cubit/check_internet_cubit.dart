import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/check_internet/internet_cubit/check_internet_states.dart';

class CheckInternetCubit extends Cubit<CheckInternetState>{
  CheckInternetCubit() : super(InitailInternetState());

  static CheckInternetCubit get(context)=>BlocProvider.of(context);

  StreamSubscription? subscription;
  void checkInternet(){
    subscription=Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result==ConnectivityResult.wifi||result==ConnectivityResult.mobile){
        emit(InternetConnectedState(message: "connected"));
      }else{
        emit(InternetNotConnectedState(message: "Not Connected"));
      }
    });
  }
  @override
  Future<void> close() {
    subscription!.cancel();
    return super.close();
  }

}