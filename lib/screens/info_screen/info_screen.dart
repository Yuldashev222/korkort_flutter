import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../style/app_colors.dart';
import '../../style/app_style.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double progress =1;
  int index = 1;
  int item = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent12,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/png/iPhone$index.png"))),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 54),
                child: Column(
                  children: [
                    Row(
                      children: [

                        Container(
                          width: 98,
                          padding: const EdgeInsets.only(left: 10),
                          child: RotatedBox(
                            quarterTurns: 0,
                            child: LinearPercentIndicator(
                              padding: const EdgeInsets.all(0),
                              animation: true,
                              lineHeight: 6.0,
                              percent: progress/1>=1?1:0,
                              backgroundColor: const Color(0xffFFDFC8),
                              barRadius: const Radius.circular(20),
                              progressColor: AppColors.sliderGreen,
                            ),
                          ),
                        ),
                        Container(
                          width: 98,
                          margin: const EdgeInsets.only(left: 10),
                          child: RotatedBox(
                            quarterTurns: 0,
                            child: LinearPercentIndicator(
                              padding: const EdgeInsets.all(0),
                              animation: true,
                              lineHeight: 6.0,
                              percent:progress/2>=1?1:0,
                              backgroundColor: const Color(0xffFFDFC8),
                              barRadius: const Radius.circular(20),
                              progressColor: AppColors.sliderGreen,
                            ),
                          ),
                        ),
                        Container(
                          width: 98,
                          padding: const EdgeInsets.only(left: 10),
                          child: RotatedBox(
                            quarterTurns: 0,
                            child: LinearPercentIndicator(
                              padding: const EdgeInsets.all(0),
                              animation: true,
                              lineHeight: 6.0,
                              percent: progress/3==1?1:0,
                              backgroundColor: const Color(0xffFFDFC8),
                              barRadius: const Radius.circular(20),
                              progressColor: AppColors.sliderGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration:const BoxDecoration(
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.white.withOpacity(0.1),
                    //   spreadRadius: 7,
                    //   blurRadius: 10,
                    //   offset: const Offset(0, 10), // changes position of shadow
                    // ),
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 7,
                      blurRadius: 20,
                      offset: Offset(0, 10), // changes position of shadow
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Seamless Donation Process",
                        style: AppStyle.appBarText1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Streamlined donation process is essential for  Lumio. Users should be able to easily make a donation with just a few clicks",
                        style: AppStyle.senEmailCode,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                if(index>1){
                                  index--;
                                  progress -= 1 ;
                                  setState(() {
                                  });
                                } else{
                                  Navigator.pop(context);
                                }
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
                         const SizedBox(width: 40,),
                          Expanded(
                            child: buttonLogin(
                                onPressed: ()async {
                                  setState(() {
                                    if (index < 3) {
                                      index++;
                                    }
                                    item++;
                                    if (item >= 4) {
                                      GetStorage().write("get_started", true);
                                      Navigator.pushNamed(context, RouteList.authScreen, arguments: 1).then((value) {
                                        progress=3;
                                        setState(() {

                                        });
                                      });
                                    }
                                      progress += 1 ;

                                  });
                                },
                                label: index == 3 ? "Get Started" : 'Next',
                                isActive: true),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 54),
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
}
