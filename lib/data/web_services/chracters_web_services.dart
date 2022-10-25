import '../../constants/strings.dart';
import '../models/characters.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharaCters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuotes(String characterName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': characterName});
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
