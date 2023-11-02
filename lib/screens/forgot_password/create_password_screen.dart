import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:korkort/screens/auth/input_widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  final Map data;

  const CreatePasswordScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool isEye = true;
  bool isEye1 = true;
  bool isFieldPassword1 = false;
  bool isFieldPassword2 = false;
  String? password1;
  String? password2;
  bool isLoginPasswordError1 = false;
  bool isLoginPasswordError2 = false;
  List? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordNewPasswordLoaded) {
            Navigator.pushNamedAndRemoveUntil(context, arguments: 2, RouteList.authScreen, (route) => false);
          } else if (state is ForgotPasswordNewPasswordError) {
            // showCustomFlash("Error", context, false);
            passwordError = state.dataError?["new_password"];
            print('_CreatePasswordScreenState.build ${state.dataError}');
          }
        },
        child: Container(
          decoration: BoxDecoration(
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
                                "Hello There 🖐, Create your account",
                                style: AppStyle.appBarText1,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Enter the email associated with your account and we’ll send an email with code to reset your password.",
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
                        // boxShadow: [BoxShadow(color: AppColors.shadowColor, offset: Offset(0, 10))],
                        color: AppColors.white,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                          const SizedBox(height: 49),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Text(
                              "Create new password",
                              style: AppStyle.confirmEmail,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: inputPasswordWidget(
                              onChanged: (e) {
                                setState(() {
                                  if (e.length < 8) {
                                    isLoginPasswordError1 = true;
                                    password1 = "8ta belgi dan kambomasin";
                                  } else if (validatePasswordCustom(e) ?? false) {
                                    isLoginPasswordError1 = true;
                                    password1 = "8ta belgi dan kambomasin";
                                  } else {
                                    isLoginPasswordError1 = false;
                                    password1 = null;
                                  }
                                });                              },
                              textEditingController: passwordController1,
                              onTapEye: () {
                                setState(() {
                                  isEye = !isEye;
                                });
                              },
                              isEye: isEye,
                              password: password1,
                              isLoginError: isLoginPasswordError1,
                              onTap: () {
                                setState(() {
                                  isFieldPassword1 = true;
                                });
                                if (passwordController2.text.isEmpty) {
                                  isFieldPassword2 = false;
                                }
                              },
                              isField: isFieldPassword1,
                              onFieldSubmitted: () {
                                if (passwordController1.text.isEmpty) {
                                  setState(() {
                                    isFieldPassword1 = false;
                                  });
                                }
                              },
                            ),
                          ),
                          if (password1 != null) const SizedBox(height: 10),
                          if (password1 != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 30),
                                Text(
                                  password1 ?? "",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(color: AppColors.red),
                                ),
                              ],
                            ),
                          for (int i = 0; i < (passwordError?.length ?? 0); i++) Text(passwordError?[i]),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: inputPasswordWidget(
                              onChanged: (e) {
                                setState(() {
                                  if (passwordController1.text == e) {
                                    isLoginPasswordError2 = false;
                                  } else {
                                    isLoginPasswordError2 = true;
                                  }
                                });                              },
                              textEditingController: passwordController2,
                              onTapEye: () {
                                setState(() {
                                  isEye1 = !isEye1;
                                });
                              },
                              isEye: isEye1,
                              password: password2,
                              isLoginError: isLoginPasswordError2,
                              onTap: () {
                                setState(() {
                                  isFieldPassword2 = true;
                                });
                                if (passwordController1.text.isEmpty) {
                                  isFieldPassword1 = false;
                                }
                              },
                              isField: isFieldPassword2,
                              onFieldSubmitted: () {
                                if (passwordController2.text.isEmpty) {
                                  setState(() {
                                    isFieldPassword2 = false;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 13),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/svg/info.svg"),
                                const SizedBox(width: 8),
                                Text(
                                  "Must be 8 characters long.",
                                  style: AppStyle.validatePassword,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
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
                                      setState(() {
                                         if(!isLoginPasswordError1&&!isLoginPasswordError2) {
                                            context
                                                .read<ForgotPasswordBloc>()
                                                .add(ForgotPasswordResetNewPasswordEvent(email: widget.data["email"], code: widget.data["code"], newPassword: passwordController1.text));
                                          }
                                        }
                                      );
                                      },
                                    label: "Confirm",
                                    isActive: passwordController1.text == passwordController2.text && passwordController2.text.length >= 8 ? true : false),
                              ),
                            ],
                          ),
                          const SizedBox(height: 34),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
