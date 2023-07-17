import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkeybox_final/controller/dio/dio_helper.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/model/get_user_model.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  static GetUserCubit get(context) => BlocProvider.of(context);
  GetUserModel getUserModel = GetUserModel();
  // String name = EndPoint.name;

  getUserName(String Token) {
    DioHelper.getData(endPoint: EndPoint.getUserName, token: EndPoint.userToken)
        .then((value) {
      getUserModel = GetUserModel.fromJson(value.data);
      EndPoint.name = getUserModel.name.toString();
      print(EndPoint.name);
      emit(GetUserNameState());
      return EndPoint.name;
    });
  }

}
