import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:monkeybox_final/controller/dio/dio_helper.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/model/signup_model.dart';
import 'package:monkeybox_final/model/signup_model.dart';
import 'package:monkeybox_final/model/signup_model.dart';
import 'package:monkeybox_final/utilities/app_colors.dart';

import '../../../model/logout_model.dart';
import '../../../model/signup_model.dart';
import '../../../model/signup_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  SignUpModel signUpModel = SignUpModel();
  RegisterError registerError = RegisterError();

  register(
      String name, String email, String password, String passwordConfirmation) {
    emit(RegisterLoadingState());
    DioHelper.postData(
            endPoint: EndPoint.register,
            data: {
              'name': name,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation
            },
            token: EndPoint.userToken)
        .then((value) {
      signUpModel = SignUpModel.fromJson(value.data);
      EndPoint.userToken = signUpModel.accessToken.toString();

      // EndPoint.name = signUpModel.user!.name.toString();

      registerError = RegisterError.fromJson(value.data);
      EndPoint.error = registerError.message.toString();

      if (EndPoint.userToken.toString() != "null") {
        emit(RegisterSuccessState());
        print("token:" + EndPoint.userToken);
      } else if (EndPoint.userToken.toString() == "null") {
        print("error is : " + EndPoint.error.toString());
        emit(RegisterErrorState());
        if (EndPoint.error.toString() ==
            '{\"email\":[\"The email has already been taken.\"]}') {
          Fluttertoast.showToast(
              msg: "This email is used try another one",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (EndPoint.error.toString() ==
            '{"name":["The name field is required."]}') {
          Fluttertoast.showToast(
              msg: "Name must be more than 2 characters",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }else if (EndPoint.error.toString() ==
            '{"email":["The email field must be a valid email address."]}') {
          Fluttertoast.showToast(
              msg: "Please check email format",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        else if (EndPoint.error.toString() ==
            '{"password":["The password field is required."]}') {
          Fluttertoast.showToast(
              msg: "Password must be more than 8 characters",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }  else if (EndPoint.error.toString() ==
            '{"password":["The password field must be at least 8 characters."]}') {
          Fluttertoast.showToast(
              msg: "Password must be more than 8 characters",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (EndPoint.error.toString() ==
            '{"password":["The password field confirmation does not match."]}') {
          Fluttertoast.showToast(
              msg: "Password didn't match!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Please check email and name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: clr.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }).catchError((e) {
      print("Error:" + e.toString());
    });
  }

  LogOutModel logOutModel = LogOutModel();

logOut(String token) {
  DioHelper.postData(
      endPoint: EndPoint.logOut,
      token: EndPoint.userToken,
      data: {'token': token}).then((value) {
    logOutModel = LogOutModel.fromJson(value.data);
    print(EndPoint.userToken);
    // emit(LogoutSuccessState());
  });
}
}
