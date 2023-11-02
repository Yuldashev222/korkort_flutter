import 'dart:ui';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:korkort/bloc/auth/auth_bloc.dart';
import 'package:korkort/screens/auth/input_widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';
import '../../widgets/flash.dart';
import '../tariff/widget.dart';

String? user;

class AuthScreen extends StatefulWidget {
  final int? type;

  const AuthScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool isLogin = false;
  bool isLogin1 = true;
  bool isRegister1 = false;
  bool isEye0 = true;
  bool isEye1 = true;
  bool isLoginEmailError = false;
  bool isLoginPasswordError1 = false;
  bool isLoginPasswordError2 = false;
  bool isFieldPassword1 = false;
  bool isFieldPassword2 = false;
  bool isFieldEmail = false;
  bool isFieldLasName = false;
  bool isFieldFirstName = false;
  final _formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  String? firstName;
  String? lastName;
  String? email;
  String? password1;
  String? password2;
  bool? isLastNameError = false;
  bool? isFirstNameError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == 1) {
      isLogin = false;
    } else if (widget.type == 2) {
      isLogin= true;
    }
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if(_tabController.index==0){
        setState(() {
          if (isLogin) {
            isLogin = false;
          }
          isLogin1 = true;
          isRegister1 = false;
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController1.clear();
          passwordController2.clear();
          isLoginEmailError = false;
          isLoginPasswordError1 = false;
          isLoginPasswordError2 = false;
          email = null;
          password1 = null;
          password2 = null;
          firstName = null;
          lastName = null;
          isFieldPassword1 = false;
          isFieldPassword2 = false;
          isFieldEmail = false;
          isFieldLasName = false;
          isFieldFirstName = false;
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
      else {
        setState(() {
          isLogin = true;
          isRegister1 = true;
          isLogin1 = false;
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController1.clear();
          passwordController2.clear();
          isLoginEmailError = false;
          isLoginPasswordError1 = false;
          isLoginPasswordError2 = false;
          email = null;
          password1 = null;
          password2 = null;
          firstName = null;
          lastName = null;
          isFieldPassword1 = false;
          isFieldPassword2 = false;
          isFieldEmail = false;
          isFieldLasName = false;
          isFieldFirstName = false;
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
    });
  }

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{0: Text("Item 1"), 1: Text("Item 2")};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterLoaded) {
              isLogin = true;
              _tabController.animateTo(1);
              showCustomFlash(state.dataSuccess.toString() ?? "", context, true);
              setState(() {});
            } else if (state is RegisterError) {
              setState(() {
                firstName = state.data["first_name"] != null ? state.data["first_name"][0] : null;
                lastName = state.data["last_name"] != null ? state.data["last_name"][0] : null;
                email = state.data["email"] != null ? state.data["email"][0] : null;
                password1 = state.data["password"] != null ? state.data["password"][0] : null;
                password2 = state.data["password"] != null ? state.data["password"][0] : null;
              });
            }
            if (state is LoginLoaded) {
              if(state.data["user"]['avatar_id']==null){
                Navigator.pushNamedAndRemoveUntil(context, RouteList.deployImageScreen, (route) => false,arguments: state.data["user"]);
              }else {
                Navigator.pushNamedAndRemoveUntil(context, RouteList.mainScreen, (route) => false, arguments: state.data["user"]);
              }
            } else if (state is LoginError) {
              setState(() {
                isLoginEmailError = true;
                isLoginPasswordError1 = true;
                isLoginPasswordError2 = true;
              });
            }
          },
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.whiteAccent,
              body: Container(
                decoration: const BoxDecoration(color: AppColors.whiteAccent),
                child: Stack(
                  children: [
                    // Center(
                    //   child: CupertinoSlidingSegmentedControl(
                    //       groupValue: segmentedControlGroupValue,
                    //       children: myTabs,
                    //       onValueChanged: (i) {
                    //         setState(() {
                    //           segmentedControlGroupValue = i!;
                    //         });
                    //       }),
                    // )   ,
                    Positioned(
                        right: 0,
                        left: 90,
                        child: CustomPaint(
                          painter: MyPainter(),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 110, sigmaX: 110),
                            child: const SizedBox(
                              height: 280.0,
                              width: 280,
                            ),
                          ),
                        )),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            // color: AppColors.grey,
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 11 * 3),
                            padding: const EdgeInsets.only(left: 35, right: 35, top: 24, bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  isLogin ? "Hej, Välkommen tillbaka!" : "Hello There 🖐, Create your account",
                                  style: AppStyle.appBarText1,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  isLogin
                                      ? "Ange dina uppgifter för e-post och lösenord för att få tillgång till ditt konto."
                                      : "Var vänlig ange ditt fullständiga namn, din e-postadress och välj ett lösenord.",
                                  style: AppStyle.appBarText2,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 11 * 3, maxHeight: MediaQuery.of(context).size.height / 11 * 8),
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: AppColors.white,
                            ),
                            child: Column(children: [
                              const SizedBox(height: 24),
                              Container(
                                margin: const EdgeInsets.only(left: 24.0, right: 24),
                                child: SegmentedTabControl(
                                  controller: _tabController,
                                  radius: const Radius.circular(26),
                                  backgroundColor: AppColors.background,
                                  tabTextColor: AppColors.languageMainStyle,
                                  squeezeIntensity: 2,
                                  indicatorPadding: const EdgeInsets.only(top: 6, bottom: 6, right: 5, left: 5),
                                  height: 56,
                                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                                  textStyle: Theme.of(context).textTheme.bodyLarge,
                                  tabs: const [
                                    SegmentTab(
                                      label: 'Registrera dig',
                                      color: AppColors.green,
                                    ),
                                    SegmentTab(label: 'Logga in', color: AppColors.green),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 11 * 3 - 80, maxHeight: MediaQuery.of(context).size.height / 11 * 8 - 80),
                                child: TabBarView(physics: const BouncingScrollPhysics(), controller: _tabController, children: [
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.only(left: 24, right: 24),
                                          child: inputFullNameWidget(
                                            textEditingController: firstNameController,
                                            hint: "First name",
                                            onChanged: (e) {
                                              setState(() {
                                                if (e.isNotEmpty && e.length < 3) {
                                                  isFirstNameError = true;
                                                } else {
                                                  isFirstNameError = false;
                                                }
                                              });
                                            },
                                            validate: firstName,
                                            onTap: () {
                                              setState(() {
                                                isFieldFirstName = true;
                                              });
                                              if (passwordController1.text.isEmpty) {
                                                isFieldPassword1 = false;
                                              }
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (emailController.text.isEmpty) {
                                                isFieldEmail = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
                                              }
                                            },
                                            isNameError: isFirstNameError,
                                            isField: isFieldFirstName,
                                            onFieldSubmitted: () {
                                              if (firstNameController.text.isEmpty) {
                                                setState(() {
                                                  isFieldFirstName = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        if (firstName != null) const SizedBox(height: 10),
                                        if (firstName != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 30),
                                              Text(
                                                firstName ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(color: AppColors.red),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.only(left: 24, right: 24),
                                          child: inputFullNameWidget(
                                            textEditingController: lastNameController,
                                            hint: "Last name",
                                            onChanged: (e) {
                                              setState(() {
                                                if (e.isNotEmpty && e.length < 3) {
                                                  isLastNameError = true;
                                                } else {
                                                  isLastNameError = false;
                                                }
                                              });
                                            },
                                            isNameError: isLastNameError,
                                            validate: lastName,
                                            onTap: () {
                                              setState(() {
                                                isFieldLasName = true;
                                              });
                                              if (passwordController1.text.isEmpty) {
                                                isFieldPassword1 = false;
                                              }
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (emailController.text.isEmpty) {
                                                isFieldEmail = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                            },
                                            isField: isFieldLasName,
                                            onFieldSubmitted: () {
                                              if (lastNameController.text.isEmpty) {
                                                setState(() {
                                                  isFieldLasName = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        if (!isLogin && lastName != null) const SizedBox(height: 10),
                                        if (!isLogin && lastName != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 30),
                                              Text(
                                                lastName ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(color: AppColors.red),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: inputEmailWidget(
                                            textEditingController: emailController,
                                            onChanged: (e) {
                                              setState(() {
                                                if (e.isNotEmpty) {
                                                  if (validateEmailForgot(e) ?? false) {
                                                    isLoginEmailError = false;
                                                  } else {
                                                    isLoginEmailError = true;
                                                  }
                                                }
                                              });
                                            },
                                            validate: email,
                                            isLoginError: isLoginEmailError,
                                            onTap: () {
                                              setState(() {
                                                isFieldEmail = true;
                                              });
                                              if (passwordController1.text.isEmpty) {
                                                isFieldPassword1 = false;
                                              }
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
                                              }
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
                                        if (email != null) const SizedBox(height: 10),
                                        if (email != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 30),
                                              Text(
                                                email ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(color: AppColors.red),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 24),
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
                                              });
                                            },
                                            textEditingController: passwordController1,
                                            onTapEye: () {
                                              setState(() {
                                                isEye0 = !isEye0;
                                              });
                                            },
                                            isEye: isEye0,
                                            password: password1,
                                            isLoginError: isLoginPasswordError1,
                                            onTap: () {
                                              setState(() {
                                                isFieldPassword1 = true;
                                              });
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (emailController.text.isEmpty) {
                                                isFieldEmail = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
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
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: inputPasswordWidget(
                                            textEditingController: passwordController2,
                                            onTapEye: () {
                                              setState(() {
                                                isEye1 = !isEye1;
                                              });
                                            },
                                            isEye: isEye1,
                                            onChanged: (e) {
                                              setState(() {
                                                if (passwordController1.text == e) {
                                                  isLoginPasswordError2 = false;
                                                } else {
                                                  isLoginPasswordError2 = true;
                                                }
                                              });
                                            },
                                            password: password2,
                                            isLoginError: isLoginPasswordError2,
                                            onTap: () {
                                              setState(() {
                                                isFieldPassword2 = true;
                                              });
                                              if (passwordController1.text.isEmpty) {
                                                isFieldPassword1 = false;
                                              }
                                              if (emailController.text.isEmpty) {
                                                isFieldEmail = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
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
                                        if (password2 != null) const SizedBox(height: 10),
                                        if (password2 != null)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 30),
                                              Text(
                                                password2 ?? "",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(color: AppColors.red),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 27),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(width: 24),
                                              const Expanded(
                                                  child: Divider(
                                                thickness: 1,
                                                color: AppColors.orSignColor,
                                              )),
                                              const SizedBox(width: 25),
                                              Text(
                                                "Or sign in with",
                                                style: AppStyle.orSign,
                                              ),
                                              const SizedBox(width: 25),
                                              const Expanded(
                                                  child: Divider(
                                                thickness: 1,
                                                color: AppColors.orSignColor,
                                              )),
                                              const SizedBox(width: 24),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        Row(
                                          children: [
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  await signInWithGoogle(context).then((value) {
                                                    print('_AuthScreenState.build $value');
                                                    if (value.idToken != null) {
                                                      context.read<AuthBloc>().add(GoogleSignInEvent(idToken: value.idToken!));
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/logos_google-icon.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 13),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  signOut();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/basil_apple-solid.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 13),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  // await signInWithFacebook();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/logos_facebook.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: buttonLogin(
                                              onPressed: () {
                                                if (passwordController1.text == passwordController2.text &&
                                                    passwordController1.text.length >= 8 &&
                                                    firstNameController.text != "" &&
                                                    lastNameController.text != "" &&
                                                    emailController.text != "") {
                                                  if (!isLoginPasswordError2 && !isLoginPasswordError1 && !(isFirstNameError ?? false) && !(isLastNameError ?? false) && !isLoginEmailError) {
                                                    setState(() {});
                                                    context.read<AuthBloc>().add(Register(
                                                        firstName: firstNameController.text, lastName: lastNameController.text, email: emailController.text, password: passwordController1.text));
                                                    setState(() {
                                                      firstName = null;
                                                      lastName = null;
                                                      email = null;
                                                      password1 = null;
                                                      password2 = null;
                                                      isLoginPasswordError2 = false;
                                                      isLoginPasswordError1 = false;
                                                      isLoginEmailError = false;
                                                    });
                                                  }
                                                }
                                                final isValid = _formKey.currentState?.validate();
                                                if (!isValid!) {
                                                  return;
                                                }
                                                _formKey.currentState?.save();
                                              },
                                              label: isLogin ? "Logga in mig" : "FORTSÄTTT",
                                              isActive: (!isLoginPasswordError2 && !isLoginPasswordError1 && (!(isFirstNameError ?? false)) && (!(isLastNameError ?? false)) && !isLoginEmailError) &&
                                                      passwordController1.text == passwordController2.text &&
                                                      passwordController1.text.length >= 8 &&
                                                      firstNameController.text != "" &&
                                                      lastNameController.text != "" &&
                                                      emailController.text != ""
                                                  ? true
                                                  : false),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(user ?? "")
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24),
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: inputEmailWidget(
                                            textEditingController: emailController,
                                            onChanged: (e) {
                                              setState(() {
                                                if (e.isNotEmpty) {
                                                  if (validateEmailForgot(e) ?? false) {
                                                    isLoginEmailError = false;
                                                  } else {
                                                    isLoginEmailError = true;
                                                  }
                                                }
                                              });
                                            },
                                            validate: email,
                                            isLoginError: isLoginEmailError,
                                            onTap: () {
                                              setState(() {
                                                isFieldEmail = true;
                                              });
                                              if (passwordController1.text.isEmpty) {
                                                isFieldPassword1 = false;
                                              }
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
                                              }
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
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: inputPasswordWidget(
                                            onChanged: (e) {
                                              setState(() {});
                                            },
                                            textEditingController: passwordController1,
                                            onTapEye: () {
                                              setState(() {
                                                isEye0 = !isEye0;
                                              });
                                            },
                                            isEye: isEye0,
                                            password: password1,
                                            isLoginError: isLoginPasswordError1,
                                            onTap: () {isLoginPasswordError1=false;
                                              setState(() {
                                                isFieldPassword1 = true;
                                              });
                                              if (passwordController2.text.isEmpty) {
                                                isFieldPassword2 = false;
                                              }
                                              if (emailController.text.isEmpty) {
                                                isFieldEmail = false;
                                              }
                                              if (firstNameController.text.isEmpty) {
                                                isFieldFirstName = false;
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                isFieldLasName = false;
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
                                        if (!isLogin && password1 != null) const SizedBox(height: 10),
                                        if (!isLogin && password1 != null)
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
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, RouteList.forgotPasswordScreen);
                                              },
                                              child: Text(
                                                "Forgot password",
                                                style: AppStyle.forgotPassword,
                                              ),
                                            ),
                                            const SizedBox(width: 24)
                                          ],
                                        ),
                                        const SizedBox(height: 27),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(width: 24),
                                              const Expanded(
                                                  child: Divider(
                                                thickness: 1,
                                                color: AppColors.orSignColor,
                                              )),
                                              const SizedBox(width: 25),
                                              Text(
                                                "Or sign in with",
                                                style: AppStyle.orSign,
                                              ),
                                              const SizedBox(width: 25),
                                              const Expanded(
                                                  child: Divider(
                                                thickness: 1,
                                                color: AppColors.orSignColor,
                                              )),
                                              const SizedBox(width: 24),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        Row(
                                          children: [
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  await signInWithGoogle(context).then((value) {
                                                    if (value.idToken != null) {
                                                      context.read<AuthBloc>().add(GoogleSignInEvent(idToken: value.idToken!));
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/logos_google-icon.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 13),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  signOut();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/basil_apple-solid.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 13),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  // await signInWithFacebook();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.white,
                                                    border: Border.all(color: AppColors.orSignColor, width: 1),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset("assets/svg/logos_facebook.svg"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 24),
                                          child: buttonLogin(
                                              onPressed: () {
                                                if (passwordController1.text.length >= 8 && emailController.text != "" && isLogin && !isLoginEmailError) {
                                                  String? emailValidate = validateEmail(emailController.text);
                                                  if (emailValidate != null) {
                                                    isLoginEmailError = true;
                                                    setState(() {});
                                                  } else {
                                                    context.read<AuthBloc>().add(
                                                          Login(email: emailController.text, password: passwordController1.text),
                                                        );
                                                  }
                                                }
                                                final isValid = _formKey.currentState?.validate();
                                                if (!isValid!) {
                                                  return;
                                                }
                                                _formKey.currentState?.save();
                                              },
                                              label: isLogin ? "Logga in mig" : "FORTSÄTTT",
                                              isActive: (isLogin && passwordController1.text.length >= 8 && emailController.text != "" && !isLoginEmailError) ? true : false),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(user ?? "")
                                      ],
                                    ),
                                  ),
                                ]),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}


Future<GoogleSignInAuthentication> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  return googleAuth;
}

signOut() async {
  await GoogleSignIn().disconnect();
}

