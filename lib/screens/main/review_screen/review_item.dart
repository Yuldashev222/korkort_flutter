import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';

Widget bottomSheetSuccess({int? trueAnswer, int? falseAnswer, Function? onTap,Function?onTapExit}) {
  return Container(
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)), color: AppColors.white),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Stack(
            children: [
              SvgPicture.asset("assets/svg/avatar_background.svg"),
              // SvgPicture.asset("assets/svg/target.svg")
            ],
          ),
          const SizedBox(height: 16),
          Text("Nice job", style: AppStyle.check),
          Text("Now you are ready to next lesson", style: AppStyle.check1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "${trueAnswer ?? 0}",
                    style: AppStyle.ballStyle,
                  ),
                  Text(
                    "Rätt",
                    style: AppStyle.ballTitle,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                width: 2,
                height: 60,
                color: AppColors.green,
              ),
              Column(
                children: [
                  Text(
                    "${falseAnswer ?? 0}",
                    style: AppStyle.ballStyle,
                  ),
                  Text(
                    "Fel",
                    style: AppStyle.ballTitle,
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 24),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      onTapExit!();
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
                const SizedBox(width: 18),
                Expanded(
                    child: buttonLogin(
                        onPressed: () {
                          onTap!();
                        },
                        label: "Next lesson",
                        isActive: true)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
