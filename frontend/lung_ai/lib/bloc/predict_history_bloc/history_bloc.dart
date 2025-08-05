import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lung_ai/bloc/predict_history_bloc/history_event.dart';
import 'package:lung_ai/bloc/predict_history_bloc/history_state.dart';
import 'package:lung_ai/services/history_service.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState>{
  final service  = HistoryService();
  HistoryBloc() : super(HistoryInitialState()) {
    on<HistoryLoadedEvent>(_onLoaded);
  }

  Future<void> _onLoaded (HistoryLoadedEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    try {
      final history = await service.history();
      if(history == null) {
        emit(HistoryBlankState());
      } else {
        emit(HistoryLoadedState(history));
      }
    } catch(e) {
      emit(HistoryErrorState('Loi lay lich su: $e'));
    }
  }
}