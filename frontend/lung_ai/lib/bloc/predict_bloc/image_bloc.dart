import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lung_ai/models/result.dart';
import 'package:lung_ai/services/predict_service.dart';

import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final picker = ImagePicker();
  final PredictService service = PredictService();
  ImageBloc() : super(ImageInitialState()) {
    on<PickImageEvent>(_onPickImage);
    on<PredictImageEvent>(_onPredictImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        add(PredictImageEvent(File(pickedFile.path)));
      }
    } catch (e) {
      emit(ImageErrorState('loi chon anh: $e'));
    }
  }

  Future<void> _onPredictImage(
    PredictImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoadingState());
    try {
      Result? result = await service.predict(event.image);
      if (result != null) {
        emit(ImageLoadedState(event.image, result));
      } else {
        emit(ImageErrorState('result = null'));
      }
    } catch (e) {
      emit(ImageErrorState('loi du doan anh: $e'));
    }
  }
}
