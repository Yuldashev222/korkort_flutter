import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyle {
  const AppStyle._();

  static TextStyle appBarText1 = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );
  static TextStyle ballStyle = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );  static TextStyle goTariff = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle ballOrangeStyle = const TextStyle(
    color: AppColors.mainOrange,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );
  static TextStyle appBarTextRed = const TextStyle(
    color: AppColors.review,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );
  static TextStyle appBarTextGreen = const TextStyle(
    color: AppColors.greenAccent,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );  static TextStyle completed = const TextStyle(
    color: AppColors.greenAccent,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.16,
    fontFamily: "Manrope",
  ); static TextStyle completedOff = const TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.16,
    fontFamily: "Manrope",
  );
  static TextStyle totalTime = const TextStyle(
    color: AppColors.greenAccent,
    fontSize: 8,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );
  static TextStyle advantagesAll = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontFamily: "Manrope",
  );
  static TextStyle editeProfile = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: "Manrope",
  );
  static TextStyle seeAll = const TextStyle(
    color: AppColors.green,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: "Manrope",
  );
  static TextStyle resendCode = const TextStyle(
    color: AppColors.green,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.12,
    fontFamily: "Manrope",
  );
  static TextStyle resendCode1 = const TextStyle(
    color: AppColors.resend,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.12,
    fontFamily: "Manrope",
  );
  static TextStyle confirmEmail = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 25,
    fontWeight: FontWeight.w700,
    fontFamily: "Manrope",
  );
  static TextStyle testCheck = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );
  static TextStyle titleOrd = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle titleOrdLine = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.confirmEmail,
    decorationStyle: TextDecorationStyle.solid,
  );
  static TextStyle textOrd = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    fontFamily: "Manrope",
  );
  static TextStyle testStyle = const TextStyle(
    color: AppColors.confirmEmail,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: "Manrope",
  );
  static TextStyle appBarText2 = const TextStyle(
    color: AppColors.blackAppBarText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle subGoTariff = const TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle forgotPassword = const TextStyle(
    color: AppColors.greenAccent,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle language = const TextStyle(
    color: AppColors.languageStyle,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle mainLanguage = const TextStyle(
    color: AppColors.languageMainStyle,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );
  static TextStyle appBarStyle = const TextStyle(
    color: AppColors.blackDark,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );  static TextStyle appBarStyle12 = const TextStyle(
    color: AppColors.blackDark,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );  static TextStyle nameAvatar = const TextStyle(
    color: AppColors.nameAvatar,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );
  static TextStyle statistic = const TextStyle(
    color: AppColors.lessonDark1,
    fontSize: 12,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle reviewProgress = const TextStyle(
    color: AppColors.progress,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle ballTitle = const TextStyle(
    color: AppColors.progress,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle chartY = const TextStyle(
    color: AppColors.chartY,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: "Manrope",
  );
  static TextStyle mainNumber = const TextStyle(
    color: AppColors.mainNumber,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "Manrope",
  );
  static TextStyle loginButton = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: "Manrope",
  ); static TextStyle levelProfile = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: "Manrope",
  );
  static TextStyle title = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle loginButtonGrey = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.loginButtonGrey,
    fontFamily: "Manrope",
  );  static TextStyle logout = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.red,
    fontFamily: "Manrope",
  );
  static TextStyle loginRegister1 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: "Manrope",
  );
  static TextStyle progress1 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: "Manrope",
  );
  static TextStyle loginRegister2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
    fontFamily: "Manrope",
  );
  static TextStyle checkStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.subA,
    fontFamily: "Manrope",
  );
  static TextStyle checkStyle1 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subA,
    fontFamily: "Manrope",
  );
  static TextStyle sendCode = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle sendCode1 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle moreStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.blackText,
    fontFamily: "Manrope",
  );
  static TextStyle orSign = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.orSign,
    fontFamily: "Manrope",
  );
  static TextStyle senEmailCode = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.sendEmailCode,
    fontFamily: "Manrope",
  );  static TextStyle check1 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.sendEmailCode,
    fontFamily: "Manrope",
  );
  static TextStyle validatePassword = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.sendEmailCode,
    fontFamily: "Manrope",
  );
  static TextStyle cart = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.sub2,
    fontFamily: "Manrope",
  );
  static TextStyle tariff0 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black1,
    fontFamily: "Manrope",
  );
  static TextStyle couponError = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle couponRabError = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.red,
    fontFamily: "Manrope",
  );
  static TextStyle couponTitleCheck = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle promo = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black1,
    fontFamily: "Manrope",
  );
  static TextStyle sub1 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle sub2 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.blackText,
    fontFamily: "Manrope",
  );
  static TextStyle tariff1 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.orange,
    fontFamily: "Manrope",
  ); static TextStyle advantage = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.orange,
    fontFamily: "Manrope",
  );
  static TextStyle tariff2 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black1,
    fontFamily: "Manrope",
  );
  static TextStyle check = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle tariff = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.blackO,
    fontFamily: "Manrope",
  );
  static TextStyle progress = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.green,
    fontFamily: "Manrope",
  );
  static TextStyle mainStyleProgress = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.green,
    fontFamily: "Manrope",
  );
  static TextStyle mainStyleRedProgress = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.mainRed,
    fontFamily: "Manrope",
  );
  static TextStyle mainStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.mainGrey,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButton = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonButton,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButtonNGrey = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonDark1,
    fontFamily: "Manrope",
  );  static TextStyle balance = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonDark1,
    letterSpacing: -0.16,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButton1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonButton,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButtonGrey = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonDark2,
    fontFamily: "Manrope",
  );
  static TextStyle couponTitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lessonDark2,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButton2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lessonButton,
    fontFamily: "Manrope",
  );
  static TextStyle lessonButton2Grey = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lessonDark1,
    fontFamily: "Manrope",
  );
  static TextStyle tariffSubtitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.subtitle,
    fontFamily: "Manrope",
  );
  static TextStyle imageName = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.name,
    fontFamily: "Manrope",
  );  static TextStyle subtitleName = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.profileName,
    fontFamily: "Manrope",
  );  static TextStyle subtitleName1 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.profileSubtitle,
    fontFamily: "Manrope",
  );
  static TextStyle name = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.name,
    fontFamily: "Manrope",
  );
  static TextStyle total = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.subA,
    fontFamily: "Manrope",
  );
  static TextStyle lessonTitle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.lessonDark,
    fontFamily: "Manrope",
  );
  static TextStyle tabBarLabel = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.lessonDark,
    fontFamily: "Manrope",
  );
  static TextStyle lessonTitle1 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lessonDark1,
    fontFamily: "Manrope",
  );
  static TextStyle advantages = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle oneType = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
    letterSpacing: -0.14
  );
  static TextStyle profileItem = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.blackAppBarText,
    fontFamily: "Manrope",
  );
  static TextStyle subtitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.subtitleColor,
    fontFamily: "Manrope",
  );  static TextStyle lessonsTeg = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitleColor,
    fontFamily: "Manrope",
  );
  static TextStyle discount = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.green,
    fontFamily: "Manrope",
  );
  static TextStyle couponMoney = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.green,
    fontFamily: "Manrope",
  );
  static TextStyle discountPrice = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.lineThrough,
    color: AppColors.discountPrice,
    fontFamily: "Manrope",
  );static TextStyle promoCode = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.balance,
    fontFamily: "Manrope",
  );
  static TextStyle appBarStylePrivacy = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.appBar,
    fontFamily: "Manrope",
  );
  static TextStyle levelStyle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle levelBallStyle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle tariffGo = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: "Manrope",
  );
  static TextStyle check12 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(62, 62, 62, 0.40),
    fontFamily: "Manrope",
  );
  static TextStyle couponButtonTitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.couponButtonTitle,
    fontFamily: "Manrope",
  ); static TextStyle couponButtonSubtitle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.couponButtonSubtitle,
    fontFamily: "Manrope",
  );static TextStyle couponButtonTr = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.couponButtonTitle,
    fontFamily: "Manrope",
  );
  static TextStyle privacyTitle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.nameF,
    fontFamily: "Manrope",
  );  static TextStyle progressReviewTitle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );  static TextStyle progressReviewTitleCategory = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );
  static TextStyle progressReviewTitle1 = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );
  static TextStyle stat = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );
  static TextStyle level1 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle bookTitle = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSuccess,
    fontFamily: "Manrope",
  );
  static TextStyle level = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.level,
    fontFamily: "Manrope",
  );
  static TextStyle statSubtitle = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );
  static TextStyle target = const TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w500,
    color: AppColors.progressReview,
    fontFamily: "Manrope",
  );
  static TextStyle slideItem = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: "Manrope",
  );   static TextStyle category = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: "Manrope",
  ); static TextStyle categoryGrey = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.loginButtonGrey,
    fontFamily: "Manrope",
  );
  static TextStyle closeWindow = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.loginButtonGrey,
    fontFamily: "Manrope",
    decoration: TextDecoration.underline,
  );static TextStyle balanceBac = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: AppColors.greenAccent,
    letterSpacing: 1,
    fontFamily: "Manrope",
  );static TextStyle testProgress = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(38, 38, 38, 0.40),
    fontFamily: "Manrope",
  );
}
