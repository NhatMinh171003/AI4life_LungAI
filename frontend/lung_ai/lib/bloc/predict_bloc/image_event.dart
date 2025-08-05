import 'dart:io';

abstract class ImageEvent {}

class PickImageEvent extends ImageEvent {}

class PredictImageEvent extends ImageEvent {
  final File image;
  PredictImageEvent(this.image);
}