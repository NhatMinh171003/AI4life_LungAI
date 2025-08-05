import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lung_ai/bloc/predict_history_bloc/history_event.dart';
import 'package:lung_ai/views/history_detail.dart';

import '../bloc/predict_history_bloc/history_bloc.dart';
import '../bloc/predict_history_bloc/history_state.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryBloc()..add(HistoryLoadedEvent()),
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoadedState) {
              if (state.history.isEmpty) {
                return Center(child: Text("Chưa có lịch sử."));
              }

              return ListView.builder(
                itemCount: state.history.length,
                itemBuilder: (context, index) {
                  final item = state.history[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        "Kết quả: ${item.label} (${(item.confidence).toStringAsFixed(1)}%)",
                      ),
                      subtitle: Text("Lúc: ${item.timestamp?.toLocal()}"),
                      trailing: Icon(Icons.medical_services),
                      onTap: () {
                        // Show probabilities
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HistoryDetailView(result: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is HistoryErrorState) {
              return Center(child: Text(state.message));
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
