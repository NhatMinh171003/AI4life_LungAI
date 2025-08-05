import 'dart:io';

import 'package:lung_ai/models/result.dart';

abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  final File image;
  final Result result;

  ImageLoadedState(this.image, this.result);
}

class ImageErrorState extends ImageState {
  final String message;

  ImageErrorState(this.message);
}