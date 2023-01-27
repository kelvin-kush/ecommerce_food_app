import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/loader.dart';
import 'package:food_app/base/show_message.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/models/signup_model.dart';
import 'package:food_app/pages/auth/signin_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  var signUpImages = [
    't.png',
    'ff.png',
    'g.png',
  ];
  void _registration() {
    AuthController authcontroller = Get.find<AuthController>();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    AuthController.phoneNumber = phone;
    if (name.isEmpty) {
      showCustomSnackBar('Type in your name', title: 'Name');
    } else if (phone.isEmpty) {
      showCustomSnackBar('Type in your phone number', title: 'Phone');
    } else if (email.isEmpty) {
      showCustomSnackBar('Type in your email', title: 'Email');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Type in a valid email address', title: 'Email');
    } else if (password.isEmpty) {
      showCustomSnackBar('Type in your password', title: 'Password');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can\'t be less than six characters',
          title: 'Password');
    } else {
      SignUpBody signUpBody = SignUpBody(
          name: name, phone: phone, email: email, password: password);
      authcontroller.registration(signUpBody).then((status) {
        if (status.isSuccess) {
          //  print('Successful Registration');
          showCustomSnackBar('Successful Registration', title: 'Success');

          Get.toNamed(RouteHelper.otpPage);
        } else if (status.message == 'Forbidden') {
          showCustomSnackBar('Account already exist');
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   nameController.dispose();
  //   phoneController.dispose();
  // }
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
                    const Text(
                      'Create a new account',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: Dimensions.height45,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.emailAddress,
                      controller: emailController,
                      text: 'Email',
                      iconData: Icons.email,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.visiblePassword,
                      controller: passwordController,
                      isObscure: true,
                      text: 'password',
                      iconData: Icons.password_sharp,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.name,
                      controller: nameController,
                      text: 'Name',
                      iconData: Icons.person,
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    AppTextField(
                      keyboardtype: TextInputType.phone,
                      controller: phoneController,
                      text: 'Phone',
                      iconData: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration();
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
                          'Sign up',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimensions.font26),
                        )),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 18),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => const SignInPage(),
                                    transition: Transition.fade),
                              text: 'Sign in',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ]),
                    ),
                    SizedBox(height: Dimensions.height10),
                    RichText(
                      text: TextSpan(
                        text: 'Sign up using one of the following',
                        style: TextStyle(color: Colors.grey[500], fontSize: 18),
                      ),
                    ),
                    // Wrap(
                    //   children: List.generate(
                    //       signUpImages.length,
                    //       (index) => Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: CircleAvatar(
                    //                 foregroundColor: Colors.white,
                    //                 backgroundColor: Colors.white,
                    //                 radius: Dimensions.radius30,
                    //                 backgroundImage: AssetImage(
                    //                     'assets/images/${signUpImages[index]}')),
                    //           )),
                    // )
                  ],
                ),
              );
      })),
    );
  }
}
