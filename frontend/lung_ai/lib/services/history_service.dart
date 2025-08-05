import 'dart:convert';
import 'dart:ui';

import 'package:lung_ai/models/result.dart';
import 'package:http/http.dart' as http;
class HistoryService {
  final String uri = 'http://127.0.0.1:5000/history';
  Future<List<Result>?> history() async {
    try {
      final response = await http.get(Uri.parse(uri));
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final history = data.map((doc) => Result.fromJson(doc)).toList();
        print(data);
        return history;
      } else {
        return null;
      }
    }catch(e) {
      throw Exception(e);
    }
  }
}