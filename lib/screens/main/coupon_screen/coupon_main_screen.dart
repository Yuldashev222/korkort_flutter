import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/bloc/profile/profile_bloc.dart';
import 'package:korkort/bloc/swish/swish_bloc.dart';
import 'package:korkort/style/app_colors.dart';

import '../../../style/app_style.dart';
import '../../../widgets/button_login.dart';
import '../../auth/input_widget.dart';
import '../../tariff/widget.dart';

class CouponMainScreen extends StatefulWidget {
  const CouponMainScreen({Key? key}) : super(key: key);

  @override
  State<CouponMainScreen> createState() => _CouponMainScreenState();
}

class _CouponMainScreenState extends State<CouponMainScreen> {
  bool isBalance = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(ProfileGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Coupons",
          style: AppStyle.appBarStylePrivacy,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset("assets/svg/exit.svg", color: AppColors.blackIntro),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: AppColors.whiteAccent,
        child: Stack(
          children: [
            Positioned(
                child: CustomPaint(
              painter: MyPainter(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 110, sigmaX: 110),
                child: const SizedBox(
                  height: 233.0,
                  width: 233,
                ),
              ),
            )),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 28, right: 28),
                  padding: const EdgeInsets.only(left: 7, right: 7, bottom: 14, top: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        spreadRadius: 0,
                        blurRadius: 15.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isBalance = false;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: isBalance ? Colors.transparent : AppColors.green),
                                    borderRadius: BorderRadius.circular(44),
                                    boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), offset: Offset(0, 2), spreadRadius: 0, blurRadius: 10)]),
                                child: SvgPicture.asset("assets/svg/bitcoin.svg",height: 46,width: 46,),),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Promo code",
                            style: AppStyle.promoCode,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isBalance = true;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(44),
                                    border: Border.all(color: isBalance ? AppColors.green : Colors.transparent),
                                    boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), offset: Offset(0, 2), spreadRadius: 0, blurRadius: 10)]),
                                child: SvgPicture.asset("assets/svg/coupon_balance.svg")),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Balamnce",
                            style: AppStyle.promoCode,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [BoxShadow(color: Color.fromRGBO(87, 111, 133, 0.07), blurRadius: 32, offset: Offset(0, -20))]),
                    child: isBalance
                        ? BlocConsumer<SwishBloc, SwishState>(
                            listener: (context, state) {
                              if (state is SwishLoaded) {
                                isBalance = false;
                                setState(() {});
                              }
                            },
                            builder: (context, state) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: BlocConsumer<ProfileBloc, ProfileState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    if (state is ProfileLoaded) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 63),
                                          Container(
                                            padding: const EdgeInsets.only(top: 15, bottom: 12, left: 10, right: 10),
                                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.balanceBac),
                                            child: Center(
                                              child: Text(
                                                "${state.profileResponse?.bonusMoney ?? "0"} SEK",
                                                style: AppStyle.balanceBac,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 18),
                                          Text("Your balance", style: AppStyle.tariff0),
                                          const SizedBox(height: 3),
                                          Text(
                                            "When you accumulate over 500 SEK, you can withdraw your earnings.",
                                            textAlign: TextAlign.center,
                                            style: AppStyle.couponTitleCheck,
                                          ),
                                          const SizedBox(height: 26),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: couponCommentWidget(
                                                textEditingController: textEditingController,
                                                hint: "Skriv ditt Swish..",
                                                onChange: (e) {
                                                  setState(() {});
                                                }),
                                          ),
                                        ],
                                      );
                                    }
                                    return const Center();
                                  },
                                ),
                              );
                            },
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 45),
                              SvgPicture.asset(
                                "assets/svg/bitcoin.svg",
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(height: 16),
                              Text("Your code", style: AppStyle.tariff0),
                              const SizedBox(height: 15),
                              Text(
                                "Dela den med din vän och båda får 30% rabatt! När din vän använder din kod, kommer du också att belönas med 30% av den totala summan som tack för att du delade med dig.",
                                style: AppStyle.couponTitleCheck,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 28),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.white,
                                    boxShadow: const [BoxShadow(offset: Offset(0, -20), blurRadius: 32, color: Color.fromRGBO(87, 111, 133, 0.07))]),
                                margin: const EdgeInsets.symmetric(horizontal: 45),
                                child: DottedBorder(
                                  padding: const EdgeInsets.only(left: 22, right: 22, top: 17, bottom: 17),
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(136),
                                  dashPattern: const [10, 10],
                                  color: const Color(0xFFEFEFEF),
                                  strokeWidth: 2,
                                  child: BlocConsumer<ProfileBloc, ProfileState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      if (state is ProfileLoaded) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.profileResponse?.userCode ?? "",
                                              style: AppStyle.promo,
                                            ),
                                            Tooltip(
                                              onTriggered: () {
                                                Clipboard.setData(ClipboardData(text: state.profileResponse?.userCode ?? ""));
                                              },
                                              message: 'Copied',
                                              preferBelow: false,
                                              triggerMode: TooltipTriggerMode.tap,
                                              child: SvgPicture.asset("assets/svg/copy.svg"),
                                            )
                                          ],
                                        );
                                      }
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "",
                                            style: AppStyle.promo,
                                          ),
                                          InkWell(onTap: () {}, child: SvgPicture.asset("assets/svg/copy.svg"))
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.only(left: 25, right: 25, bottom: 32),
                  child: buttonLogin(
                      onPressed: () {
                        if (isBalance) {
                          context.read<SwishBloc>().add(SwishPostEvent(number: int.parse(textEditingController.text)));
                        }
                      },
                      label: isBalance ? "Withdraw" : 'Share your code',
                      isActive: !isBalance || textEditingController.text.length > 9),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
