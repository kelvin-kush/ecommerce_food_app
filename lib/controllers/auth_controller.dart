import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/data/repository/card_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isloading => _isloading;
  static String phoneNumber = '';
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isloading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);

      responseModel = ResponseModel(true, response.body['token']);
     // phoneNumber = signUpBody.phone;
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(
      String phone, String password) async {
    _isloading = true;
    update();
    Response response = await authRepo.login(phone,  password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      print('My token is ${response.body['token']}');
      responseModel = ResponseModel(
        true,
        response.body['token'],
      );
    } else {
      responseModel = ResponseModel(false, response.statusText!,
          statusCode: response.statusCode);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLogedIn() {
    return authRepo.userLogedIn();
  }

  bool clearData() {
    return authRepo.clearData();
  }
}
