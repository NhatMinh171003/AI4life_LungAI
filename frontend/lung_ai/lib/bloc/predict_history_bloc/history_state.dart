import 'package:lung_ai/models/result.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryBlankState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<Result> history;

  HistoryLoadedState(this.history);
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState(this.message);
}