import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/route/route_constants.dart';

import '../../style/app_colors.dart';
import '../../style/app_style.dart';
import '../../widgets/button_login.dart';

class AdvantagesTariffScreen extends StatefulWidget {
  const AdvantagesTariffScreen({Key? key}) : super(key: key);

  @override
  State<AdvantagesTariffScreen> createState() => _AdvantagesTariffScreenState();
}

class _AdvantagesTariffScreenState extends State<AdvantagesTariffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.1, 0.6, 0.4],
            colors: [
              AppColors.whiteAccent,
              AppColors.greenAccent.withOpacity(0.8),
              AppColors.whiteAccent,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 62),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ta Ditt Körkort till Nästa Nivå!",
                          style: AppStyle.appBarText1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Våra kurser bjuder på fördelar som förvandlar din läsupplevelse. Din resa till ett körkort har aldrig varit så enkel!",
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
                  // boxShadow: [BoxShadow(color: AppColors.shadowColor, offset: Offset(0, 10))],
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    const SizedBox(height: 50),
                    for (int i = 0; i < 10; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 44, bottom: 15, right: 19),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/success.svg"),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                "Lär dig med våra mest populära instruktionsvideor",
                                style: AppStyle.advantages,
                              ),
                            )
                          ],
                        ),
                      ),
                    Center(
                      child: Text.rich(TextSpan(text: "", children: [
                        TextSpan(text: "Få Tillgång Från Bara ", style: AppStyle.advantagesAll),
                        TextSpan(text: "99 kr", style: AppStyle.advantage),
                      ])),
                    ),
                   const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
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
                          SizedBox(
                            width: 228,
                            child: buttonLogin(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteList.tariffScreen);
                              },
                              label: "Kör Framåt till Kassan!",
                              isActive: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
