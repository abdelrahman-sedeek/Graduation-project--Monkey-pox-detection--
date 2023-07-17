import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkeybox_final/controller/dio/dio_helper.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/model/logout_model.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  static LogoutCubit get(context) => BlocProvider.of(context);
  LogOutModel logOutModel = LogOutModel();

  logOut(String token) {
    emit(LogoutLoadingState());
    DioHelper.postData(
        endPoint: EndPoint.logOut,
        token: EndPoint.userToken,
        data: {'token': token}).then((value) {
      logOutModel = LogOutModel.fromJson(value.data);
      emit(LogoutSuccessState());
      print("eta3 bara");

    });
  }
}
