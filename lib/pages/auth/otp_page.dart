import 'package:flutter/material.dart';
import 'package:food_app/base/show_message.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/phone_controller.dart';
import 'package:food_app/models/verify_model.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/otpfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void verifyUserPhoneSms() async {
    PhoneController phonecontroller = Get.find<PhoneController>();
    String pinCode = pinController.text.trim();

    if (pinCode.isEmpty) {
      showCustomSnackBar('Type in your pincode', title: 'Pincode');
    } else if (pinCode.length < 6) {
      showCustomSnackBar('Passcode can\'t be less than six characters',
          title: 'Phone');
    } else {
      VerifyBody verifyBody =
          // VerifyBody(phone: AuthController.phoneNumber, passcode: pinCode);
          VerifyBody(phoneNumber: '0558298737', passcode: pinCode);
      await phonecontroller.verifyUserPhoneSms(verifyBody);
    }
  }

  void getUserPhoneSms() async {
    PhoneController phonecontroller = Get.find<PhoneController>();
    await phonecontroller.getUserPhoneSms();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Image.asset(
                      'assets/images/food_logo.jpg',
                      fit: BoxFit.cover,
                      //color: AppColor.appMainColor,
                    ),
                  ),
                  Text(
                    'Enter OTP',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: Dimensions.height20),
                  Text(
                    'To further ensure security, a One-Time Password(OTP) has been sent via your registered phone number ${AuthController.phoneNumber}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Directionality(
                              textDirection: TextDirection.ltr,
                              child: Pinput(
                                length: 6,
                                controller: pinController,
                                focusNode: focusNode,
                                androidSmsAutofillMethod:
                                    AndroidSmsAutofillMethod.smsUserConsentApi,
                                listenForMultipleSmsOnAndroid: true,
                                defaultPinTheme: defaultPinTheme,
                                // validator: (value) {
                                //   return value == '2222'
                                //       ? null
                                //       : 'Pin is incorrect';
                                // },
                                hapticFeedbackType:
                                    HapticFeedbackType.lightImpact,
                                // onCompleted: (pin) {
                                //   debugPrint('onCompleted: $pin');
                                // },
                                // onChanged: (value) {
                                //   debugPrint('on: $value');
                                // },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: focusedBorderColor,
                                    )
                                  ],
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(19),
                                    border:
                                        Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border:
                                        Border.all(color: Colors.redAccent)),
                              )),
                          // TextButton(
                          //   onPressed: () => formKey.currentState!.validate(),
                          //   child: const Text('Validate'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // formKey.currentState!.validate();
                        verifyUserPhoneSms();
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
                          'Verify',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimensions.font26),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t receive the OTP?',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              getUserPhoneSms();
                            },
                            child: Text('RESEND OTP')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
