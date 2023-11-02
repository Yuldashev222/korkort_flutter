import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/style/app_colors.dart';

import '../../route/route_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage storage = GetStorage();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    openNextPage(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: Center(
        child: Image.asset("assets/png/logo.png"),
      ),
    );
  }

  openNextPage(BuildContext context) async {
    Timer(const Duration(milliseconds: 3000), () {
      if (storage.read("token") != null) {
          Navigator.pushNamedAndRemoveUntil(context, RouteList.mainScreen, (route) => false,arguments: 1);
      } else if(storage.read("get_started")==null){
        Navigator.pushNamedAndRemoveUntil(context, RouteList.language, (route) => false);
      } else if(storage.read("get_started")){
        Navigator.pushNamedAndRemoveUntil(context, RouteList.authScreen, (route) => false,arguments: 1);
      }
    });
  }
}
