import 'package:flutter/cupertino.dart';
import 'package:korkort/model/lesson_response.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/auth/auth_screen.dart';
import 'package:korkort/screens/deploy_image/deploy_image_screen.dart';
import 'package:korkort/screens/forgot_password/create_password_screen.dart';
import 'package:korkort/screens/forgot_password/forgot_password_screen.dart';
import 'package:korkort/screens/forgot_password/send_email_code_screen.dart';
import 'package:korkort/screens/info_screen/info_screen.dart';
import 'package:korkort/screens/main/coupon_screen/coupon_main_screen.dart';
import 'package:korkort/screens/main/coupon_screen/order_screen.dart';
import 'package:korkort/screens/main/home/chart_screen.dart';
import 'package:korkort/screens/main/home/lesson_screen.dart';
import 'package:korkort/screens/main/main_page.dart';
import 'package:korkort/screens/main/profile_screen/edite_profile_screen.dart';
import 'package:korkort/screens/main/profile_screen/level_screen.dart';
import 'package:korkort/screens/main/profile_screen/todo_up_screen.dart';
import 'package:korkort/screens/main/review_screen/review_screen.dart';
import 'package:korkort/screens/main/success/categories_screen.dart';
import 'package:korkort/screens/main/success/test/test_success_screen.dart';
import 'package:korkort/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:korkort/screens/splash_screen/splash_screen.dart';
import 'package:korkort/screens/tariff/tariff_screen.dart';
import 'package:korkort/screens/tariff/web_view_screen.dart';

import '../screens/advantages_tariff/advantages_tariff_screen.dart';
import '../screens/check/check_screen.dart';
import '../screens/create_card/create_card_screen.dart';
import '../screens/deploy_image/success_image_screen.dart';
import '../screens/forgot_password/check_code_screen.dart';
import '../screens/language_selection/language_selection_screen.dart';
import '../screens/main/book_screen/book_list_screen.dart';
import '../screens/main/book_screen/book_screen.dart';
import '../screens/main/home/test_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const SplashScreen(),
        RouteList.language: (context) => const LanguageSelectionScreen(),
        RouteList.authScreen: (context) =>AuthScreen(type: setting.arguments as int,),
        RouteList.forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
        RouteList.sendEmailCodeScreen: (context) => const SendEmailCodeScreen(),
        RouteList.createPasswordScreen: (context) =>  CreatePasswordScreen(data: setting.arguments as Map),
        RouteList.checkCodeScreen: (context) =>  CheckCodeScreen(email: setting.arguments as String),
        RouteList.createCardScreen: (context) => const CreateCardScreen(),
        RouteList.tariffScreen: (context) => const TariffScreen(),
        RouteList.deployImageScreen: (context) =>  DeployImageScreen(dataInfo: setting.arguments as Map),
        RouteList.successImageScreen: (context) => SuccessImageScreen(imageId: setting.arguments as int),
        RouteList.checkScreen: (context) => CheckScreen(id: setting.arguments as int,),
        RouteList.mainScreen: (context) => const MainScreen(),
        RouteList.webViewScreen: (context) => const WebViewScreen(),
        RouteList.lessonScreen: (context) => LessonScreen(
              id: setting.arguments as int,
            ),
        RouteList.privacyPolicyScreen: (context) => const PrivacyPolicyScreen(),
        RouteList.advantagesTariffScreen: (context) => const AdvantagesTariffScreen(),
        RouteList.testScreen: (context) => TestScreen(testData: setting.arguments as List,),
        RouteList.infoScreen: (context) => const InfoScreen(),
        RouteList.chartScreen: (context) => ChartScreen(
              id: setting.arguments as int,
            ),
        RouteList.editeProfileScreen: (context) =>  EditeProfileScreen(profileResponse: setting.arguments as ProfileResponse),
        RouteList.reviewScreen: (context) =>  ReviewScreen(data: setting.arguments as Map),
        RouteList.categoriesScreen: (context) => const CategoriesScreen(),
        RouteList.orderScreen: (context) => const OrderScreen(),
        RouteList.couponMainScreen: (context) => const CouponMainScreen(),
        RouteList.todoUp: (context) => const TodoUpScreen(),
        RouteList.testSuccessScreen: (context) =>  TestSuccessScreen(timerAndData: setting.arguments as List),
        RouteList.level: (context) => const LevelScreen(),
        RouteList.bookList: (context) => const BookListScreen(),
        RouteList.book: (context) =>   BookScreen(data: setting.arguments as List,),

  };
}
