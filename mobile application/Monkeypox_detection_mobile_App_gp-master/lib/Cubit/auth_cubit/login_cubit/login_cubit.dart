import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:monkeybox_final/controller/dio/dio_helper.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/model/login_model.dart';
import 'package:monkeybox_final/utilities/app_colors.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel = LoginModel();
  LoginError loginError = LoginError();

  login(String email, String password) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: EndPoint.login,
      data: {
        'email': email,
        'password': password,
      },
      token: EndPoint.userToken,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      EndPoint.userToken = loginModel.accessToken.toString();
      // EndPoint.name = loginModel.user!.name.toString();
      loginError = LoginError.fromJson(value.data);
      EndPoint.error = loginError.error.toString();

      if (EndPoint.userToken.toString() != "null") {
        emit(LoginSuccessState());
        print('token is  ${EndPoint.userToken}');
      } else if (EndPoint.userToken.toString() == "null") {
        print('Error : ' + EndPoint.error);
        Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: clr.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);

        emit(LoginErrorState());
      }
    });
  }
}
