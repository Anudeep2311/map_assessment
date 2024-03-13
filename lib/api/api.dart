import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:map_assessment/models/user_model.dart';

String apiKey = dotenv.env['API_KEY']!;

class ApiService {
  final Dio _dio = Dio();

  // Future<void> getUserData() async {
  //   try {
  //     Response response = await _dio.get('https://reqres.in/api/users');
  //     return response;
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     return Response(
  //         requestOptions: RequestOptions(
  //             path: ''));
  //   }
  // }

  Future<UserModel> fetchDataForAddress(String address) async {
    try {
      Response response = await _dio.get('https://reqres.in/api/users');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Error fetching data");
    }
  }
}
