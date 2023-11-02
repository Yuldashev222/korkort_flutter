import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';

class SuccessImageScreen extends StatefulWidget {
  final int? imageId;
  const SuccessImageScreen({Key? key,this.imageId}) : super(key: key);

  @override
  State<SuccessImageScreen> createState() => _SuccessImageScreenState();
}

class _SuccessImageScreenState extends State<SuccessImageScreen> {
  bool isActive = false;
  int avatarItem = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    openNextPage(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.1, 0.9, 0.6, 0.2],
            colors: [
              AppColors.whiteAccent,
              AppColors.greenAccent.withOpacity(0.7),
              AppColors.whiteAccent,
              AppColors.whiteAccent,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          "Din Körkortsresa Börjar Här!",
                          style: AppStyle.appBarText1,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Var vänlig ange ditt fullständiga namn, din e-postadress och välj ett lösenord.",
                          style: AppStyle.appBarText2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 84),

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(child: Container(
                            margin: EdgeInsets.only(left: 30),
                              // color: Colors.red,
                              child: SvgPicture.asset("assets/svg/illustration.svg"))),
                          Center(
                            child: SvgPicture.asset(
                              "assets/svg_avatar/50 Monsters Avatar Icons_${widget.imageId} 1.svg",height: 196,width: 196,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),
                      Center(
                        child: Text(
                          "Ahmad Murodov",
                          style: AppStyle.name
                          ,
                        ),
                      ),
                      Center(
                        child: Text(
                          "garokmusubi88@gmail.com",
                          style: AppStyle.subtitleName1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  openNextPage(BuildContext context) async {
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushNamed(context, RouteList.mainScreen);
    });
  }
}
