part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistorySuccess extends HistoryState {}
