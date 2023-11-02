import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';

import '../../bloc/check_payment/check_payment_bloc.dart';
import '../../pdf_generate.dart';
import '../tariff/widget.dart';

class CheckScreen extends StatefulWidget {
  final int id;

  const CheckScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool isActive = false;
  num? price;
  num? subtotal;
  num? rabat;
  num? moms;
  num? total;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CheckPaymentBloc>().add(CheckGetCreateEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteAccent
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   stops: const [0.1, 0.9, 0.6, 0.2],
          //   colors: [
          //     AppColors.whiteAccent,
          //     AppColors.greenAccent.withOpacity(0.7),
          //     AppColors.whiteAccent,
          //     AppColors.whiteAccent,
          //   ],
          // ),
        ),
        child: Stack(
          children: [
            Positioned(
                right: 0,
                left: 0,
                child: CustomPaint(
                  painter:  MyPainter(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY:120, sigmaX: 120),
                    child:  const SizedBox(
                      height: 300.0,
                      width: 300,
                    ),
                  ),
                )),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/done.svg",
                          ),
                          const SizedBox(width: 4),
                           const Flexible(
                            child: DottedLine(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              lineLength: double.infinity,
                              lineThickness: 2.0,
                              dashLength: 4.0,
                              dashColor: AppColors.onProgress,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            "assets/svg/done.svg",
                          ),
                          const SizedBox(width: 4),
                          const Flexible(
                            child: DottedLine(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              lineLength: double.infinity,
                              lineThickness: 2.0,
                              dashLength: 4.0,
                              dashColor: AppColors.onProgress,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            "assets/svg/done.svg",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<CheckPaymentBloc, CheckPaymentState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is CheckPaymentLoaded) {
                      num totalTariff = state.checkOrderResponse?.tariffPrice ?? 0;
                      num rabat = (state.checkOrderResponse?.tariffDiscountAmount ?? 0) + (state.checkOrderResponse?.studentDiscountAmount ?? 0) + (state.checkOrderResponse?.studentBonusAmount ?? 0);
                      num subtotal = (totalTariff - rabat) * 0.75;
                      num moms = (totalTariff - rabat) * 0.25;
                      num total = totalTariff - rabat;
                      return Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.only(right: 25, left: 25),
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
                                  const SizedBox(height: 46),
                                  Center(
                                    child: SvgPicture.asset(
                                      "assets/svg/success_check.svg",
                                      // height: 90,
                                      // width: 90,
                                    ),
                                  ),
                                  const SizedBox(height: 23),
                                  Text(
                                    "Tack För Ditt Köp",
                                    style: AppStyle.check,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 43),
                                    child: Text(
                                      "Ditt Kvitto Syns Nedan. Nu är det Dags att Kasta Loss och Studera!",
                                      style: AppStyle.check1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${state.checkOrderResponse?.tariffDay??""} dagars paket allt ingår",
                                            style: AppStyle.checkStyle,
                                          ),
                                          Text(
                                            "Beställnings nr: #${state.checkOrderResponse?.orderId??""}",
                                            style: AppStyle.checkStyle1,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                       Text("$totalTariff kr")
                                    ],
                                  ),
                                  const SizedBox(height: 19),
                                  const Divider(
                                    color: AppColors.subA,
                                    height: 1,
                                  ),
                                  const SizedBox(height: 20),
                                  if(rabat>0)
                                    Row(
                                    children: [
                                      Text(
                                        "Rabatt",
                                        style: AppStyle.checkStyle,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "-$rabat kr",
                                        style: AppStyle.checkStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: AppStyle.checkStyle,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$subtotal kr",
                                        style: AppStyle.checkStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Moms",
                                        style: AppStyle.checkStyle,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$moms kr",
                                        style: AppStyle.checkStyle,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    color: AppColors.subA,
                                    height: 1,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Total",
                                        style: AppStyle.total,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$total kr",
                                        style: AppStyle.total,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 36),
                                  Container(
                                    child: buttonLogin(
                                      onPressed: () {
                                        openFile(codeItem: state.checkOrderResponse?.orderId,day:state.checkOrderResponse?.tariffDay ,price: totalTariff,rabat: rabat,subtotal: subtotal,moms: moms,total: total);
                                        Navigator.pushNamedAndRemoveUntil(context, RouteList.mainScreen, (route) => false);
                                        // Navigator.pushNamed(context, RouteList.mainScreen);
                                      },
                                      label: "Kör Framåt till Kassan!",
                                      isActive: true,
                                    ),
                                  ),
                                  const SizedBox(height: 23),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, RouteList.privacyPolicyScreen);
                                      },
                                      child: Text(
                                        "Integritetspolicy & Användarvillkor",
                                        style: AppStyle.tariffSubtitle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              )),
                        ),
                      );
                    }
                    return Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.only(right: 25, left: 25),
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: AppColors.white,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                            ),
                          ),
                        ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
