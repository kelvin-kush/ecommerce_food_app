import 'package:food_app/base/show_message.dart';
import 'package:food_app/data/repository/phone_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/verify_model.dart';

import 'package:get/get.dart';

class PhoneController extends GetxController implements GetxService {
  final PhoneRepo phoneRepo;

  PhoneController({
    required this.phoneRepo,
  });

  String errorMessage = '';
  bool error = false;

  Future<ResponseModel> getUserPhoneSms() async {
    late ResponseModel responseModel;
    try {
      Response response = await phoneRepo.getUserPhoneSms();

      if (response.statusCode == 200) {
        error = false;
        responseModel = ResponseModel(true, response.body['token']);
      } else {
        error = true;
        errorMessage = 'check your internet connection';
        // responseModel = ResponseModel(false, response.statusText!);
        print(response.statusCode);
        print(response.statusText);
      }
    } catch (e) {
      error = true;
      errorMessage = e.toString();
    }
    return responseModel;
  }

  bool _isloading = false;
  bool get isloading => _isloading;
  Future<void> verifyUserPhoneSms(VerifyBody verifyBody) async {
    late ResponseModel responseModel;
    _isloading = true;
    update();

    Response response = await phoneRepo.verifyUserPhoneSms(verifyBody);

    if (response.statusCode == 200) {
      showCustomSnackBar(response.statusText!);
    } else {
      showCustomSnackBar(response.statusText!);
    }
    _isloading = false;
    update();
  
  }
}
