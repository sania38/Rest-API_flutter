import 'package:dio/dio.dart';

class AvatarService {
  final Dio _dio = Dio();

  Future<String?> generateAvatar(String styleName, String? seed) async {
    try {
      String url = 'https://api.dicebear.com/8.x/$styleName/svg';
      if (seed != null && seed.isNotEmpty) {
        url += '?seed=$seed';
      }
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
