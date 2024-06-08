import 'package:dio/dio.dart';

class AvatarService {
  final Dio _dio = Dio();

  Future<String> fetchAvatar() async {
    try {
      final response =
          await _dio.get("https://api.dicebear.com/8.x/pixel-art/svg");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load avatar');
      }
    } catch (error) {
      throw Exception('Failed to load avatar: $error');
    }
  }
}
