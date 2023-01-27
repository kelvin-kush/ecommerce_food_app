import 'package:food_app/base/show_message.dart';
import 'package:food_app/data/repository/phone_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/verify_model.dart';
import 'package:food_app/routes/route_helper.dart';

import 'package:get/get.dart';

class PhoneController extends GetxController implements GetxService {
  final PhoneRepo phoneRepo;

  PhoneController({
    required this.phoneRepo,
  });

  String errorMessage = '';
  bool error = false;

  Future<void> getUserPhoneSms() async {
    late ResponseModel responseModel;
    try {
      Response response = await phoneRepo.getUserPhoneSms();

      if (response.statusCode == 200) {
        error = false;
        print(response.body['status']);
      } else {
        error = true;
        errorMessage = 'check your internet connection';
        showCustomSnackBar('check your internet connection');
      }
    } catch (e) {
      error = true;
      errorMessage = e.toString();
    }
  }

  bool _isloading = false;
  bool get isloading => _isloading;
  Future<void> verifyUserPhoneSms(VerifyBody verifyBody) async {
    late ResponseModel responseModel;
    _isloading = true;
    update();

    Response response = await phoneRepo.verifyUserPhoneSms(verifyBody);

    if (response.statusCode == 200) {
      if (response.body['responseCode'] == '00') {
        successCustomSnackBar('Succeessful');
        Get.offNamed(RouteHelper.getInitial());
      } else {
        showCustomSnackBar('Invalid Passcode');
      }
    } else {
      showCustomSnackBar('check your internet connection');
    }
    _isloading = false;
    update();
  }
}
