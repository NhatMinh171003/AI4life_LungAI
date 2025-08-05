import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/predict_bloc/image_bloc.dart';
import '../bloc/predict_bloc/image_event.dart';
import '../bloc/predict_bloc/image_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageInitialState) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                onPressed: () =>
                    context.read<ImageBloc>().add(PickImageEvent()),
                child: Text('Chọn ảnh X-quang'),
              );
            } else if (state is ImageLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ImageLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(state.image,
                      width: MediaQuery.of(context).size.width * 0.8, // 80% chiều rộng màn hình
                      height: 500,
                      fit: BoxFit.contain,),
                    SizedBox(height: 20),
                    Text(
                      'Kết quả: ${state.result.label}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Độ chính xác: ${(state.result.confidence ).toStringAsFixed(2)}%',
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                      onPressed: () =>
                          context.read<ImageBloc>().add(PickImageEvent()),
                      child: Text('Chọn ảnh khác'),
                    ),
                  ],
                ),
              );
            } else if (state is ImageErrorState) {
              return Text(state.message);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
