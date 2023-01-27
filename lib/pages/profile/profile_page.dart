import 'package:flutter/material.dart';
import 'package:food_app/base/loader.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/icon.dart';
import 'package:food_app/widgets/profile_widget.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLogedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();

      print('user got');
    }
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            backgroundColor: AppColor.appMainColor),
        body: GetBuilder<UserController>(builder: (usercontroller) {
          return usercontroller.isloading && !usercontroller.error
              ? const Center(child: CustomLoader())
              : usercontroller.error
                  ? Center(child: Text(usercontroller.errorMessage))
                  : Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppIcon(
                              icon: Icons.person,
                              iconSize: Dimensions.height150 / 1.8,
                              backhroundColor: AppColor.appMainColor,
                              iconColor: Colors.white,
                              size: Dimensions.height150,
                            ),
                            SizedBox(height: Dimensions.height30),
                            ProfileWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  iconSize: Dimensions.height20,
                                  backhroundColor: AppColor.appMainColor,
                                  iconColor: Colors.white,
                                  size: Dimensions.height10 * 4,
                                ),
                                text: usercontroller.userModel.name),
                            SizedBox(height: Dimensions.height20),
                            ProfileWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  iconSize: Dimensions.height20,
                                  backhroundColor: Colors.blue[300],
                                  iconColor: Colors.white,
                                  size: Dimensions.height10 * 4,
                                ),
                                text: usercontroller.userModel.phone),
                            SizedBox(height: Dimensions.height20),
                            ProfileWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  iconSize: Dimensions.height20,
                                  backhroundColor: Colors.yellow[300],
                                  iconColor: Colors.white,
                                  size: Dimensions.height10 * 4,
                                ),
                                text: usercontroller.userModel.email),
                            SizedBox(height: Dimensions.height20),
                            ProfileWidget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  iconSize: Dimensions.height20,
                                  backhroundColor: Colors.yellow[300],
                                  iconColor: Colors.white,
                                  size: Dimensions.height10 * 4,
                                ),
                                text: 'Kelvin'),
                            SizedBox(height: Dimensions.height20),
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLogedIn()) {
                                  Get.find<AuthController>().clearData();
                                  Get.find<CartController>().clear();
                                  Get.find<CartController>().clearCartData();
                                  Get.offNamed(RouteHelper.getSignIn());
                                }
                              },
                              child: ProfileWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout_sharp,
                                    iconSize: Dimensions.height20,
                                    backhroundColor: Colors.red[300],
                                    iconColor: Colors.white,
                                    size: Dimensions.height10 * 4,
                                  ),
                                  text: 'Logout'),
                            ),
                            SizedBox(height: Dimensions.height20),
                          ],
                        ),
                      ),
                    );
        }));
  }
}
