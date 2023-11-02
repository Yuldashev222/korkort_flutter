import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/screens/auth/input_widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../bloc/forgot_password/forgot_password_bloc.dart';
import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoginEmailError = false;
  bool isFieldEmail = false;
  String errorV = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoaded) {
            Navigator.pushNamed(context, RouteList.checkCodeScreen, arguments: emailController.text);
          } else if (state is ForgotPasswordError) {
            // showCustomFlash("error", context, false);
            errorV = "Enter a valid email address.";
            setState(() {});
          }else if (state is ForgotTimePasswordError) {
            errorV = "Vaqt tugadi 3 tadan kop yubordiz";
            setState(() {});
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteAccent
          ),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  left: 0,
                  child: CustomPaint(
                    painter:  MyPainter(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY:90, sigmaX: 90),
                      child:  const SizedBox(
                        height: 320.0,
                        width: 320,
                      ),
                    ),
                  )),
              Column(
                children: [
                  const SizedBox(
                    height: 68,
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35, top: 62),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t Worry!",
                                style: AppStyle.appBarText1,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Easily reset your password by entering email",
                                style: AppStyle.appBarText2,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: AppColors.white,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 54),
                            Padding(
                              padding: const EdgeInsets.only(left: 32, right: 32),
                              child: Text(
                                "Confirm your email",
                                style: AppStyle.confirmEmail,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 32, right: 32),
                              child: Text(
                                "Enter the email associated with your account and we’ll send an email with code to reset your "
                                "password.",
                                style: AppStyle.appBarText2,
                              ),
                            ),
                            const SizedBox(height: 41),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                              ),
                              child: inputEmailWidget(
                                textEditingController: emailController,
                                onChanged: (e) {
                                  setState(() {
                                    if(e.isNotEmpty){
                                      if (validateEmailForgot(e) ?? false) {
                                        isLoginEmailError=false;
                                      } else {
                                        isLoginEmailError=true;
                                      }                                    }
                                  });
                                },
                                validate: null,
                                isLoginError: isLoginEmailError,
                                onTap: () {
                                  setState(() {
                                    isFieldEmail = true;
                                  });
                                },
                                isField: isFieldEmail,
                                onFieldSubmitted: () {
                                  if (emailController.text.isEmpty) {
                                    setState(() {
                                      isFieldEmail = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            if (errorV != "") const SizedBox(height: 10),
                            if (errorV != "")
                              Padding(
                                padding: const EdgeInsets.only(left: 32.0, right: 32),
                                child: Text(
                                  errorV,
                                  style: const TextStyle(color: AppColors.red),
                                ),
                              ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 24),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppColors.greenAccent,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/svg/exit.svg",
                                          color: AppColors.white,
                                        ))),
                                SizedBox(
                                  width: 228,
                                  child: buttonLogin(
                                      onPressed: () {
                                        if (validateEmailForgot(emailController.text) ?? false) {
                                          context.read<ForgotPasswordBloc>().add(ForgotPasswordResetCodeEvent(email: emailController.text));
                                        } else {
                                          errorV = "Please enter email";
                                        }
                                        setState(() {});
                                      },
                                      label: "Confirm",
                                      isActive: validateEmailForgot(emailController.text) ?? false),
                                ),
                                const SizedBox(width: 24),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
