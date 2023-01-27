import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/loader.dart';
import 'package:food_app/base/show_message.dart';
import 'package:food_app/pages/auth/signup_page.dart';
import 'package:food_app/routes/route_helper.dart';

import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
   TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
      phoneController.dispose();
    }

    void _login() {
      AuthController authcontroller = Get.find<AuthController>();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password can\'t be less than six characters',
            title: 'Password');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone');
      } else {
        authcontroller.login(phone,  password).then((status) {
          if (status.isSuccess) {
            successCustomSnackBar('Login Successful', title: 'Success');
            Get.toNamed(RouteHelper.getInitial());
          } 
           else if (status.message == 'unauthorized') {
             showCustomSnackBar('Incorrect login details');
           }
          else {
            showCustomSnackBar(status.message);
            print(status.statusCode);
          }
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<AuthController>(builder: (controller) {
        return controller.isloading
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/food_logo.jpg')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              Dimensions.width30, 0, Dimensions.width20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: Dimensions.height45,
                                    fontWeight: FontWeight.bold),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Sign into your account',
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                   
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.visiblePassword,
                      controller: passwordController,
                      text: 'password',
                      isObscure: true,
                      iconData: Icons.password_sharp,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.phone,
                      controller: phoneController,
                      text: 'phone',
                      iconData: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    SizedBox(height: Dimensions.height10),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _login();
                      },
                      child: Container(
                        width: Dimensions.screnWidth / 2,
                        height: Dimensions.screnHeight / 13,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: Colors.yellow[700]),
                        child: Center(
                            child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimensions.font26),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    SizedBox(height: Dimensions.height10),
                    RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 18),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => SignUpPage(),
                                    transition: Transition.fade),
                              text: 'Create',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ]),
                    ),
                  ],
                ),
              );
      })),
    );
  }
}
