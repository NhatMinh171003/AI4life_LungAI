import 'package:flutter/foundation.dart';

import '../utils/parse_date.dart';

class Result {
  final String label;
  final double confidence;
  final Map<String, double> probabilities;
  final DateTime? timestamp;
  final String imageBase64;
  final String gradCamBase64;
  Result({
    required this.label,
    required this.confidence,
    required this.probabilities,
    required this.timestamp,
    required this.imageBase64,
    required this.gradCamBase64
  });

  factory Result.fromJson(Map<String, dynamic> resultJson) {
    return Result(
      label: resultJson['label'],
      confidence: (resultJson['confidence'] as num).toDouble(),
      probabilities: {
        "Pneumonia": (resultJson['probabilities']['Pneumonia'] as num)
            .toDouble(),
        "Normal": (resultJson['probabilities']['Normal'] as num).toDouble(),
      },
      timestamp: resultJson['timestamp'] != null
          ? parseDate(resultJson['timestamp'])
          : null,
      imageBase64: resultJson['image_base64'] ?? '',
      gradCamBase64: resultJson['gradcam_base64'] ?? ''
    );
  }

}
