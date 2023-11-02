import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/app_colors.dart';
import '../../style/app_style.dart';

Widget languageButtonItemWidget({required Function onTap,required bool isActive,required String languageName,required String assetsName}) {
  return GestureDetector(
    onTap:(){
      onTap();
    },
    child: Container(

      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.white,
          border: Border.all(
            color:isActive? AppColors.greenAccent:Colors.transparent,
            width: 1,
          ),
        // border: OutlinedBorder(side: BorderSide()),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorLanguage.withOpacity(0.1),
            offset: const Offset(0, 0.12),
            spreadRadius: 5, //spread radius
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 21, bottom: 21, right: 11),
            child: SvgPicture.asset("assets/svg/$assetsName.svg"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 9),
              Text(
                "Select language",
                style: AppStyle.language,
              ),
              Text(
                languageName,
                style: AppStyle.mainLanguage,
              ),
              const SizedBox(height: 9),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 15, right: 21),
            child: isActive ? SvgPicture.asset("assets/svg/check2.svg") : SvgPicture.asset("assets/svg/check1.svg"),
          )
        ],
      ),
    ),
  );
}

Widget languageButtonChangeProfile({required Function onTap, required bool isActive, required String languageName, required String assetsName}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        border: Border.all(
          color: isActive ? AppColors.greenAccent : Colors.transparent,
          width: 1,
        ),
        // border: OutlinedBorder(side: BorderSide()),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.shadowColorLanguage.withOpacity(0.1),
        //     offset: const Offset(0, 0.12),
        //     spreadRadius: 5, //spread radius
        //     blurRadius: 7,
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 11),
            child: SvgPicture.asset("assets/svg/$assetsName.svg"),
          ),
          Text(
            languageName,
            style: AppStyle.mainLanguage,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 15, right: 21),
            child: isActive ? SvgPicture.asset("assets/svg/check_circle.svg") : const SizedBox(),
          )
        ],
      ),
    ),
  );
}
