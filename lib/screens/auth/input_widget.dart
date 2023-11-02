import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/style/app_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../style/app_colors.dart';

final maskPasswordFormatter = MaskTextInputFormatter(mask: '', filter: {"#": RegExp(r'^[a-zA-Z0-9\W_]+$')});
final couponFormatter = MaskTextInputFormatter(mask: '######', filter: {"#": RegExp(r'^[a-zA-Z0-9\W_]+$')});
final couponFormatterEdite = MaskTextInputFormatter(mask: '##########', filter: {"#": RegExp(r'^[0-9]')});

String? validatePassword(String value) {
  RegExp regex = RegExp(r'^(?=.*\d)[^\d]{8}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}bool? validatePasswordCustom(String value) {
  final RegExp digitRegex = RegExp(r'^[0-9]+$');
  return digitRegex.hasMatch(value);
  }


String? validateEmail(String value) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'Please enter email';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
}
bool? validateEmailForgot(String value) {
  RegExp regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  if (value.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}

Widget inputFullNameWidget(
    {required TextEditingController textEditingController, required String hint, required Function(String) onChanged, required String? validate, Function? onTap, bool? isField, Function?
    onFieldSubmitted,bool? isNameError,}) {
  return Container(
    padding: EdgeInsets.only(top: isField! ? 10 : 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: AppColors.white, boxShadow: [
      BoxShadow(
        color: AppColors.shadowColorLanguage.withOpacity(0.1),
        offset: const Offset(0, 0.12),
        spreadRadius: 5, //spread radius
        blurRadius: 7,
      ),
    ]),
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        onChanged: (e) {
          onChanged(e);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(hint == "Last name" ? 100 : 50),
        ],
        validator: (value) {
          // if (value == null) {
          //   return "Is empty";
          // } else if (validate != null) {
          //   return validate;
          // } else {
          //   return null;
          // }
        },
        onFieldSubmitted: (a) {
          onFieldSubmitted!();
        },
        onTap: () {
          onTap!();
        },
        cursorColor: AppColors.greenAccent,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontWeight: FontWeight.normal, color: (isNameError??false)?AppColors.red:Colors.black),
        decoration: InputDecoration(
          prefixIcon: Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.only(left: 20, right: 10, bottom: isField ? 15 : 0),
              child: SvgPicture.asset(
                "assets/svg/user.svg",
                height: 19,
                width: 15,
                color: textEditingController.text.isNotEmpty ?(isNameError??false)?AppColors.red: AppColors.blackIntro : AppColors.categoryGrey,
              )),
          labelText: hint,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.languageStyle,
          ),
          contentPadding: const EdgeInsets.only(
            left: 0,
            top: 0,
            bottom: 0,
            right: 20
          ),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    ),
  );
}
Widget inputNameWidget(
    {required TextEditingController textEditingController, required String hint, required Function onChanged, required String? validate, Function? onTap, bool? isField, Function? onFieldSubmitted}) {
  return Container(
    padding: EdgeInsets.only(top: isField! ? 10 : 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: AppColors.white, boxShadow: [
      BoxShadow(
        color: AppColors.shadowColorLanguage.withOpacity(0.1),
        offset: const Offset(0, 0.12),
        spreadRadius: 5, //spread radius
        blurRadius: 7,
      ),
    ]),
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        onChanged: (e) {
          onChanged();
        },
        validator: (value) {
          // if (value == null) {
          //   return "Is empty";
          // } else if (validate != null) {
          //   return validate;
          // } else {
          //   return null;
          // }
        },
        onFieldSubmitted: (a) {
          onFieldSubmitted!();
        },
        onTap: () {
          onTap!();
        },
        cursorColor: AppColors.greenAccent,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.only(left: 20, right: 10, bottom: isField ? 15 : 0),
              child: SvgPicture.asset(
                "assets/svg/profile_edite.svg",
                height: 19,
                width: 15,
              )),
          labelText: hint,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.languageStyle,
          ),
          contentPadding: const EdgeInsets.only(
            left: 0,
            top: 0,
            bottom: 0,
          ),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    ),
  );
}

Widget inputEmailWidget(
    {required TextEditingController textEditingController, required Function(String) onChanged, required String? validate, bool? isLoginError, Function? onTap, bool? isField, Function?
    onFieldSubmitted}) {
  return Container(
    padding: EdgeInsets.only(top: isField! ? 10 : 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: AppColors.white, boxShadow: [
      BoxShadow(
        color: AppColors.shadowColorLanguage.withOpacity(0.1),
        offset: const Offset(0, 0.12),
        spreadRadius: 5, //spread radius
        blurRadius: 7,
      ),
    ]),
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(254),
        ],
        onChanged: (e) {
          onChanged(e);
        },
        validator: (value) {
          // if (validate != null) {
          //   return validate;
          // } else {
          //   return validateEmail(value!);
          // }
        },
        onFieldSubmitted: (a) {
          onFieldSubmitted!();
        },
        onTap: () {
          onTap!();
        },
        cursorColor: AppColors.greenAccent,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontWeight: FontWeight.normal, color: isLoginError ?? false ? AppColors.red : AppColors.blackIntro),
        decoration: InputDecoration(
          prefixIcon: Container(
              height: 26,
              width: 26,
              margin: EdgeInsets.only(left: 20, right: 10, bottom: isField ? 15 : 0),
              child: SvgPicture.asset(
                "assets/svg/email.svg",
                height: 19,
                width: 15,
                color: isLoginError ?? false
                    ? AppColors.red
                    : textEditingController.text.isNotEmpty
                        ? AppColors.blackIntro
                        : AppColors.categoryGrey,
              )),
          labelText: 'Email Address',
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.languageStyle),
          contentPadding: const EdgeInsets.only(
            left: 60,
            top: 0,
            bottom: 16,
          ),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    ),
  );
}

Widget inputPasswordWidget(
    {required TextEditingController textEditingController,
    required Function onTapEye,
    required bool isEye,
    required Function(String) onChanged,
    required String? password,
    bool? isLoginError,
    Function? onTap,
    bool? isField,
    Function? onFieldSubmitted}) {
  return Container(
    padding: EdgeInsets.only(top: isField! ? 10 : 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowColorLanguage.withOpacity(0.1),
          offset: const Offset(0, 0.12),
          spreadRadius: 5, //spread radius
          blurRadius: 7,
        ),
      ],
    ),
    child: TextFormField(
      controller: textEditingController,
      onChanged: (e) {
        onChanged(e);
        if (e.contains(' ')) {
          textEditingController.text = e.replaceAll(' ', '');
        }
      },
      onFieldSubmitted: (a) {
        onFieldSubmitted!();
      },
      onTap: () {
        onTap!();
      },
      obscureText: isEye,
      cursorColor: AppColors.greenAccent,
      keyboardType: TextInputType.emailAddress,
      validator: (e) {
        // if (password != null) {
        //   return password;
        // } else {
        //   return validatePassword(e!);
        // }
      },
      inputFormatters: [LengthLimitingTextInputFormatter(128), maskPasswordFormatter],
      style: TextStyle(fontWeight: FontWeight.normal, color: isLoginError ?? false ? AppColors.red : AppColors.blackIntro),
      decoration: InputDecoration(
        prefixIcon: Container(
            height: 26,
            width: 26,
            margin: EdgeInsets.only(left: 20, right: 10, bottom: isField ? 15 : 0),
            child: SvgPicture.asset(
              "assets/svg/lock.svg",
              height: 19,
              width: 15,
              color: isLoginError ?? false
                  ? AppColors.red
                  : textEditingController.text.isNotEmpty
                      ? AppColors.blackIntro
                      : AppColors.categoryGrey,
            )),
        suffixIcon: GestureDetector(
          onTap: () {
            onTapEye();
          },
          child: Container(
              // width: 3,
              // height: 19,
              margin: const EdgeInsets.only(right: 17, top: 15, bottom: 15),
              child: SvgPicture.asset(
                "assets/svg/eye-${!isEye ? "on" : "off"}.svg",
                height: 19,
                width: 25,
              )),
        ),
        labelText: 'Password',
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.languageStyle),
        contentPadding: const EdgeInsets.only(
          left: 0,
          top: 0,
          bottom: 0,
        ),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: AppColors.white)),
      ),
    ),
  );
}

Widget couponWidget({required TextEditingController textEditingController,FocusNode?focusNode, Function? onTap, bool? isError}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: AppColors.white, boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.04),
        offset: Offset(10, 24),
        spreadRadius: 0, //spread radius
        blurRadius: 54,
      ),
    ]),
    child: Center(
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        onChanged: (e) {},
        validator: (value) {
          if (value!.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
        inputFormatters: [couponFormatter],
        cursorColor: AppColors.greenAccent,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontWeight: FontWeight.normal, color: isError ?? false ? AppColors.red : AppColors.blackIntro),
        decoration: InputDecoration(
          hintText: 'Title',
          suffixIcon: Container(
            width: 90,
            margin: const EdgeInsets.only(right: 6, top: 5, bottom: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(right: 6, top: 5, bottom: 5),
                backgroundColor: AppColors.greenAccent,
              ),
              onPressed: () {
                print('couponWidget');
                onTap!();
              },
              child: Center(
                child: Text(
                  "Tillämpa",
                  style: AppStyle.loginButton,
                ),
              ),
            ),
          ),
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.languageStyle),
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.greenAccent)),
        ),
      ),
    ),
  );
}
Widget couponCommentWidget({required TextEditingController textEditingController, Function(String)? onChange, bool? isError,String?hint}) {
  return DottedBorder(
    // pad/
    borderType: BorderType.RRect,
    radius: const Radius.circular(136),
    dashPattern: const [10, 10],
    color: const Color(0xFFEFEFEF),
    strokeWidth: 2,
    child: Center(
      child: TextFormField(
        controller: textEditingController,
        onChanged: (e) {
          onChange!(e);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
        inputFormatters: [couponFormatterEdite],
        cursorColor: AppColors.greenAccent,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontWeight: FontWeight.normal, color: isError ?? false ? AppColors.red : AppColors.blackIntro),
        decoration: InputDecoration(
          hintText: hint??"",
          suffixIcon:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset("assets/png/swish_logo.png",height: 8,width: 8,),
          ),
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.languageStyle),
          contentPadding:const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          isDense: true,
          border: InputBorder.none,

          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          // disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.white)),
          // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: AppColors.greenAccent)),
        ),
      ),
    ),
  );
}
