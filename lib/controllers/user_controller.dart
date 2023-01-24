import 'package:food_app/data/repository/user_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/usermodel.dart';

import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
//  final UserModel userModel;

  UserController({
    required this.userRepo,
  });

  bool _isloading = false;
  UserModel _userModel =
      UserModel(id: 0, name: '', email: '', phone: '', orderCount: 0);
  UserModel get userModel => _userModel;

  String errorMessage = '';
  bool error = false;

  bool get isloading => _isloading;
// late UserModel get userModel =>
  //    _userModel ;

  Future<void> getUserInfo() async {
    _isloading = true;
    update();
    try {
      Response response = await userRepo.getUserInfo();
      late ResponseModel responseModel;

      if (response.statusCode == 200) {
        _userModel =
            UserModel(id: 0, name: '', email: '', phone: '', orderCount: 0);
        _userModel = UserModel.fromJson(response.body);
        //  responseModel = ResponseModel(true, 'successfully');
        error = false;
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
      _userModel =
          UserModel(id: 0, name: '', email: '', phone: '', orderCount: 0);
    }

    _isloading = false;
    update();
    //  return responseModel;
  }
}
