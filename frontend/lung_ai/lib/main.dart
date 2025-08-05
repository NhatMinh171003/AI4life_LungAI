import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lung_ai/views/home_navigator.dart';
import 'package:lung_ai/views/home_view.dart';

import 'bloc/predict_bloc/image_bloc.dart';

void main() {
  runApp(const LungAiApp());
}

class LungAiApp extends StatelessWidget {
  const LungAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LungAi',
      home:BlocProvider(create: (context) => ImageBloc(),
      child: HomeNavigator(),) ,
    );
  }
}

