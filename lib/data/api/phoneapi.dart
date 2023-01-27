import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/phone_controller.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  PhoneApiClient({
    required this.appBaseUrl,
  }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);

    _mainHeaders = {
      'x-app-id': 'SpotFine',
    };
  }

  // Future<Response> getUserPhoneSms(String uri, {Map<String, String>? headers}) async {
  //   try {
  //     Response response = await get(uri, headers: headers ?? _mainHeaders);
  //     return response;
  //   } catch (e) {
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }

  Future<Response> postUserPhoneSms(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    print(body.toString());
    try {
      Response response = await post('$uri?phoneNumber=${AuthController.phoneNumber}', body, headers: _mainHeaders);
      // Response response = await post('$uri?phoneNumber=0558298737', body,
      //     headers: _mainHeaders);
      print(response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusText: e.toString());
    }
  }
   Future<Response> verifyUserPhoneSms(String uri, dynamic body ) async {
    print(body.toString());
    try {
      Response response = await post(uri, body);
      print(response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusText: e.toString());
    }
  }
}
