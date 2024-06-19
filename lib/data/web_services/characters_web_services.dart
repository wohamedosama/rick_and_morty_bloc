import 'package:flutter_rick_and_morty/core/constants/string.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60), //30 second
        receiveTimeout: const Duration(seconds: 60));
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
    Response response = await dio.get('character');
    print(response.data['results']);

    return response.data['results'];
  }
}
