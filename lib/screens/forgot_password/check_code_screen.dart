import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';
import 'custom.dart';

class CheckCodeScreen extends StatefulWidget {
  final String email;

  const CheckCodeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  TextEditingController smsController = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  bool isScroll = false;
  late String errorMessage;
  late final ScrollController controller = ScrollController();
  late Size size;
  final focusNode = FocusNode();
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 59);

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isScroll = true;
        });
        controller.animateTo(size.height / 4, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      } else {
        setState(() {
          isScroll = false;
        });
      }
    });
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    setState(() {});
    const reduceSecondsBy = 1;
    var seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      seconds = 0;
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      // resizeToAvoidBottomInset: true,
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordCheckLoaded) {
            Navigator.pushNamed(context, RouteList.createPasswordScreen, arguments: {"email": widget.email, "code": smsController.text});
          } else if (state is ForgotPasswordCheckError) {
            setState(() {
              hasError = true;
            });
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                  right: 0,
                  left: 0,
                  child: CustomPaint(
                    painter: MyPainter(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 90, sigmaX: 90),
                      child: const SizedBox(
                        height: 320.0,
                        width: 320,
                      ),
                    ),
                  )),
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 12 * 4),
                    padding: const EdgeInsets.only(left: 35, right: 35, top: 62, bottom: 62),
                    child: Center(
                      child: Text(
                        "Instruction Sent to Your Email!",
                        style: AppStyle.appBarText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                        ),
                        child:SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 49),
                              SvgPicture.asset(
                                'assets/svg/email_image.svg',
                              ),
                              const SizedBox(height: 17),
                              Text(
                                "Enter the 6 digit code",
                                style: AppStyle.sendCode,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Please confirm your account by entering the authorization code sen to ${widget.email}",
                                style: AppStyle.senEmailCode,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: PinCodeTextField(
                                  focusNode: focusNode,
                                  onTap: () {},
                                  autofocus: false,
                                  controller: smsController,
                                  hideCharacter: false,
                                  highlight: true,
                                  highlightColor: AppColors.greenAccent,
                                  defaultBorderColor: AppColors.borderCode,
                                  hasTextBorderColor: AppColors.borderCode,
                                  highlightPinBoxColor: AppColors.white,
                                  maxLength: 6,
                                  hasError: hasError,
                                  pinBoxRadius: 12,
                                  maskCharacter: "⚫️",
                                  onTextChanged: (text) {
                                    // controller.animateTo(
                                    //   controller.position.maxScrollExtent,
                                    //   duration: Duration(milliseconds: 200),
                                    //   curve: Curves.easeOut,
                                    // );
                                    // controller.position.maxScrollExtent;
                                    // controller.animateTo(1, duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
                                    setState(() {
                                      print('_CheckCodeScreenState.build');
                                    });
                                  },
                                  onDone: (text) {},
                                  pinBoxWidth: 34,
                                  pinBoxHeight: 34,
                                  hasUnderline: false,
                                  wrapAlignment: WrapAlignment.end,
                                  pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                  pinTextStyle: TextStyle(fontSize: 14.0, color: hasError ? AppColors.red : AppColors.black),
                                  pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                                  pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                                  highlightAnimationBeginColor: Colors.black,
                                  highlightAnimationEndColor: Colors.white12,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(height: 2),
                              InkWell(
                                onTap: () {
                                  if (seconds == "00") {
                                    context.read<ForgotPasswordBloc>().add(ForgotPasswordResetCodeEvent(email: widget.email));
                                    startTimer();
                                  }
                                },
                                child: Text(
                                  "Resend code${seconds != "00" ? " ${seconds}s" : ""}",
                                  style: seconds != "00" ? AppStyle.resendCode1 : AppStyle.resendCode,
                                ),
                              ),
                              const SizedBox(height: 15),
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
                                    width: 250,
                                    child: buttonLogin(
                                        onPressed: () {
                                          if(seconds != "00"&&smsController.text.length == 6){
                                            context.read<ForgotPasswordBloc>().add(ForgotPasswordResetCheckCodeEvent(email: widget.email, code: smsController.text, newPassword: null));
                                          }
                                        },
                                        label: "Resend Link",
                                        isActive: smsController.text.length == 6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
