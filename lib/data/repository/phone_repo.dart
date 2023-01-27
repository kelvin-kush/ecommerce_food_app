import 'package:food_app/data/api/api.dart';
import 'package:food_app/data/api/phoneapi.dart';
import 'package:food_app/models/verify_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PhoneRepo {
  final PhoneApiClient phoneApiClient;

  PhoneRepo({required this.phoneApiClient});

  Future<Response> getUserPhoneSms() async {
    return await phoneApiClient.postUserPhoneSms(
        AppConstants.PHONE_SMS_URL, '');
  }

  Future<Response> verifyUserPhoneSms(VerifyBody verifyBody) async {
    return await phoneApiClient.verifyUserPhoneSms(
        AppConstants.PHONE_VERIFY_URL, verifyBody.toJson());
  }
}
