import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';

class SendEmailCodeScreen extends StatefulWidget {
  const SendEmailCodeScreen({Key? key}) : super(key: key);

  @override
  State<SendEmailCodeScreen> createState() => _SendEmailCodeScreenState();
}

class _SendEmailCodeScreenState extends State<SendEmailCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteAccent,
      body: Container(
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
                Expanded(
                    flex: 4,
                    child: Container(
                      color: AppColors.red,
                      padding: const EdgeInsets.only(left: 35, right: 35, top: 62),
                      child: Text(
                        "Instruction Sent to Your Email!",
                        style: AppStyle.appBarText1,
                        textAlign: TextAlign.center,
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: SingleChildScrollView(
                        physics:const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           const SizedBox(height: 24),
                            SvgPicture.asset('assets/svg/Resurs 1.svg',),
                            const SizedBox(height: 17),
                            Text(
                              "Check your email",
                              style: AppStyle.sendCode,
                            ),
                            const SizedBox(height: 9),
                            Text(
                              "Magic link has been sent to your email, please follow the instruction to reset your Lumio account password.",
                              style: AppStyle.senEmailCode,
                              textAlign: TextAlign.center,
                            ),
                           const SizedBox(height: 24),
                            buttonLogin(
                                onPressed: () {
                                  Navigator.pushNamed(context, RouteList.createPasswordScreen);
                                },
                                label: "Resend Link",
                                isActive: true),
                            const SizedBox(height: 34),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
