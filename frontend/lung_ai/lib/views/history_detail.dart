import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lung_ai/models/result.dart';

class HistoryDetailView extends StatelessWidget {
  final Result result;
  const HistoryDetailView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final decodedImage = base64Decode(result.imageBase64.split(',').last);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kết quả chuẩn đoán"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Ảnh chiếm 60-70% chiều cao màn hình
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: Image.memory(
                  decodedImage,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),

              // Chữ chiếm phần còn lại
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kết quả: ${result.label}",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "Độ tin cậy: ${result.confidence.toStringAsFixed(2)}%",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Pneumonia: ${result.probabilities['Pneumonia']?.toStringAsFixed(2)}%",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Normal: ${result.probabilities['Normal']?.toStringAsFixed(2)}%",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Thời gian: ${result.timestamp}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
