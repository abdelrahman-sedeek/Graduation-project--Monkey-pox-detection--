import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkeybox_final/controller/dio/dio_helper.dart';
import 'package:monkeybox_final/controller/dio/endpoints.dart';
import 'package:monkeybox_final/model/history_model.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of(context);
  HistoryModel historyModel = HistoryModel();
  List historyClassification = [];
  List historyImages = [];

     getHistory(String token){
       emit(HistoryLoadingState());
    DioHelper.getData(endPoint: EndPoint.history,token: EndPoint.userToken).then((value)
    {
      List<HistoryModel> history = (value.data as List)
          .map((data) => HistoryModel.fromJson(data)).toList();
      historyClassification.clear();
      history.forEach((element) {historyClassification.add(element.status);});
      print("::::::::::::::::::::::::::"+historyClassification.length.toString());
      historyImages.clear();
      history.forEach((element) {historyImages.add(element.image);});
      print("::::::::::::::::::::::::::"+historyImages
          .length.toString());
      emit(HistorySuccess());

    }).catchError((e){print(e);});
  }
}
