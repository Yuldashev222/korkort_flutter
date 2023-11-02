import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/bloc/book/book_bloc.dart';
import 'package:korkort/bloc/categories_exams/categories_exams_bloc.dart';
import 'package:korkort/bloc/categories_filter/categories_filter_bloc.dart';
import 'package:korkort/bloc/chart/chart_bloc.dart';
import 'package:korkort/bloc/check_payment/check_payment_bloc.dart';
import 'package:korkort/bloc/coupon/coupon_bloc.dart';
import 'package:korkort/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:korkort/bloc/language/language_bloc.dart';
import 'package:korkort/bloc/lessons_chapter/lessons_chapter_bloc.dart';
import 'package:korkort/bloc/lessons_question/lessons_question_bloc.dart';
import 'package:korkort/bloc/order/order_bloc.dart';
import 'package:korkort/bloc/order_check/order_check_bloc.dart';
import 'package:korkort/bloc/payment/payment_bloc.dart';
import 'package:korkort/bloc/payment_stripe/payment_stripe_bloc.dart';
import 'package:korkort/bloc/profile/profile_bloc.dart';
import 'package:korkort/bloc/swish/swish_bloc.dart';
import 'package:korkort/bloc/todo/todo_bloc.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/route/routes.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/lesson/lesson_bloc.dart';
import 'bloc/level/level_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "lattmedkorkort",
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthBloc(),
        ),
        Provider(
          create: (_) => PaymentBloc(),
        ),
        Provider(
          create: (_) => CouponBloc(),
        ),
        Provider(
          create: (_) => PaymentStripeBloc(),
        ),
        Provider(
          create: (_) => CheckPaymentBloc(),
        ),
        Provider(
          create: (_) => ForgotPasswordBloc(),
        ),
        Provider(
          create: (_) => ProfileBloc(),
        ),
        Provider(
          create: (_) => LessonsChapterBloc(),
        ),
        Provider(
          create: (_) => LessonBloc(),
        ),
        Provider(
          create: (_) => ChartBloc(),
        ),
        Provider(
          create: (_) => CategoriesExamsBloc(),
        ),
        Provider(
          create: (_) => CategoriesFilterBloc(),
        ),
        Provider(
          create: (_) => OrderBloc(),
        ),
        Provider(
          create: (_) => OrderCheckBloc(),
        ),
        Provider(
          create: (_) => LessonsQuestionBloc(),
        ),
        Provider(
          create: (_) => SwishBloc(),
        ),
        Provider(
          create: (_) => LanguageBloc(),
        ),
        Provider(
          create: (_) => LevelBloc(),
        ),
        Provider(
          create: (_) => BookBloc(),
        ),Provider(
          create: (_) => TodoBloc(),
        ),
      ],
      child:MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: RouteList.initial,
        // home:testA() ,
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder builder = routes[settings.name]!;
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}


