import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lung_ai/models/result.dart';

class PredictService {
  final String uri = 'http://localhost:5000/predict';
  Future<Result?> predict(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // key phải trùng với Flask
          imageFile.path,
        ),
      );
      var response = await request.send();
      print('Sending request to $uri');
      print('Image file path: ${imageFile.path}');
      print('Status code: ${response.statusCode}');

      if( response.statusCode == 200) {

        final resStr = await response.stream.bytesToString();
        final jsonRes = json.decode(resStr);
        print('json: ${jsonRes}');
        return Result.fromJson(jsonRes);
      } else if (response.statusCode == 400) {
        throw Exception('Lỗi tải ảnh hoặc sai định dạng ảnh');
      }
      else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }

  }
}