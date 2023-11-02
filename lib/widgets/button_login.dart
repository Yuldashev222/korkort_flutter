// import 'package:flash/flash.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/style/app_style.dart';

import '../bloc/coupon/coupon_bloc.dart';
import '../screens/auth/input_widget.dart';
import '../style/app_colors.dart';

Widget buttonLogin({required Function? onPressed, required String label, required bool isActive}) {
  return Container(
    width: double.infinity,
    child: TextButton(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: isActive ? AppColors.greenAccent : AppColors.confirmEmailGrey,
          minimumSize: const Size(double.infinity, 55),
      maximumSize: Size(double.infinity, 55)
      ),
      onPressed: () {
        onPressed!();
      },
      child: Center(
        child: Text(
          label,
          style: isActive ? AppStyle.loginButton : AppStyle.loginButtonGrey,
        ),
      ),
    ),
  );
}
Widget buttonLoginLogout({required Function? onPressed, required String label, required bool isActive}) {
  return TextButton(
    style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 55)),
    onPressed: () {
      onPressed!();
    },
    child: Center(
      child: Text(
        label,
        style: AppStyle.logout,
      ),
    ),
  );
}

Widget buttonLogin1({required Function onPressed, required String label, required bool isActive, String? isLock}) {
  return TextButton(
    style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: isActive ? AppColors.greenAccent : AppColors.confirmEmailGrey,
        minimumSize: const Size(double.infinity, 55)),
    onPressed: () {
      onPressed();
    },
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isActive) SvgPicture.asset("assets/svg/${isLock ?? 'lock'}.svg"),
          if (!isActive) const SizedBox(width: 10),
          Text(
            label,
            style: isActive ? AppStyle.loginButton : AppStyle.loginButtonGrey,
          ),
        ],
      ),
    ),
  );
}

Future<void> showMyDialog(
    {BuildContext? context, bool? isBonus, bool? isIsland, String? title, double? price, String? titleCoupon, num? priceCoupon, bool? isPercent, Function(bool, String)? functionCoupon,Function
        (int)
?successCoupon})
async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Show(
        isBonus: isBonus,
        isIsland: isIsland,
        title: title,
        titleCoupon: titleCoupon,
        price: price,
        priceCoupon: priceCoupon,
        isPercent: isPercent,
        functionCoupon: functionCoupon,
        successCoupon: successCoupon,
      );
    },
  );
}

class Show extends StatefulWidget {
  final bool? isBonus;
  final bool? isIsland;
  final String? title;
  final num? price;
  final String? titleCoupon;
  final num? priceCoupon;
  final bool? isPercent;
  final FocusNode?focusNode;
  final Function(bool, String)? functionCoupon;
  final Function(int)? successCoupon;

  const Show({
    Key? key,
    this.isBonus,
    this.focusNode,
    this.isIsland,
    this.title,
    this.price,
    this.priceCoupon,
    this.titleCoupon,
    this.isPercent,
    this.functionCoupon,
    this.successCoupon,
  }) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  bool isBonus = false;
  bool isCoupon = false;
  bool isCouponItem = false;
  bool isError = false;
  String? errorTitle;
  TextEditingController textEditingController = TextEditingController();
int count=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCouponItem = false;
  }

  List titleList=["Få tillgång till 1500? körkortsfrågor","Lär dig med våra mest populära","Lyssna på vår audiobok vart du än är","Rekommenderar av trafikskolor","Tillgång till vår webbsida och mobilapp"];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state is CouponLoaded) {
          isError = false;
          isCouponItem = true;
          errorTitle = '';
        } else if (state is CouponError) {
          if (state.typeError == 1) {
            isError = true;
            // errorTitle = "Tyvärr, den rabattkod du har angivit är ogiltig eller har redan använts";
          } else if (state.typeError == 2) {
            isError = true;
            errorTitle = "Tyvärr, den rabattkod ";
            if (state is CouponLoaded){
              if (isCouponItem){
                count++;
                widget.successCoupon!(count);
              }
            }
            if (widget.isBonus ?? false){
              if (widget.price != 0){
                count++;
                widget.successCoupon!(count);
              }
            }
            setState(() {

            });
          }
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20),
          // height: 380,
          width: 340,
          // color: Colors.red,
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 45),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/coupon_bac.svg",
                        ),
                        SvgPicture.asset(
                          "assets/svg/ticket.svg",
                        ),
                      ],
                    ),
                    Text(
                      "Skriv ditt rabattkod",
                      style: AppStyle.tariff0,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        errorTitle??"",
                        style: AppStyle.couponRabError,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    couponWidget(
                      focusNode: widget.focusNode,
                        textEditingController: textEditingController,
                        onTap: () {
                        widget.successCoupon!(1);
                            if (textEditingController.text != "" && textEditingController.text.length == 6) {
                            context.read<CouponBloc>().add(CouponCreateEvent(coupon: textEditingController.text));
                          }
                        },
                        isError: isError),
                    if (state is CouponLoaded)
                      if (isCouponItem)
                        bonusItem(
                            isActive: isCoupon,
                            onTap: () {
                              setState(() {
                                isCoupon = !isCoupon;
                                isBonus = false;
                              });
                            },
                            title: textEditingController.text,
                            price: "${widget.priceCoupon} ${widget.isPercent ?? false ? "%" : "kr"}"),
                    if (widget.isBonus ?? false)
                        bonusItem(
                            isActive: isBonus,
                            onTap: () {
                              if(widget.price==null||widget.price==0){
                              }else{
                                setState(() {
                                  isBonus = !isBonus;
                                  isCoupon = false;
                                });
                              }
                            },
                            title: widget.title,
                            price: "${widget.price??0} kr"),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: buttonLogin(
                      onPressed: () {
                        if (state is CouponLoaded) {
                          print('_ShowState.build ${isBonus} 11 ${state.coupon}');
                          widget.functionCoupon!(isBonus||isCoupon, state.coupon ?? "");
                        }
                        Navigator.pop(context);
                      },
                      label: "Tillämpa rabatkoden",
                      isActive: isCoupon || isBonus),
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close window",
                      style: AppStyle.closeWindow,
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget bonusWidget({required BuildContext context, String? image, String? title,var imageData}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 43),
            Container(
              color: AppColors.red,
              constraints: const BoxConstraints(minWidth: 144, maxWidth: 300),
              margin: const EdgeInsets.only(right: 16, left: 16),
              // child: Image.network(
              //   image ?? "",
              //   // height: 144,
              //   // width: 144,
              //   // fit: BoxFit.cover,
              // ),
              child:    Image.file(File(imageData),)
                ,
            ),
            const SizedBox(height: 33),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: Html(
                // title ,
                // style: AppStyle.tariff0,
                // textAlign: TextAlign.center,
                data: title,
              ),
            ),
          ],
        ),
        // const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
          child: buttonLogin(
              onPressed: () {
                Navigator.pop(context);
              },
              label: "Tillämpa rabatkoden",
              isActive: true),
        ),
        // const SizedBox(height: 12),
        // Center(
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Text(
        //       "Close window",
        //       style: AppStyle.closeWindow,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 40)
      ],
    ),
  );
}

Future<void> successDialog(BuildContext context, Function onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        // title: const Text("data"),
        content: SizedBox(
          height: 327,
          width: 340,
          // color: Colors.red,
          child: Column(
            children: [
              SizedBox(
                height: 162,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/kupon_background.svg",
                      color: AppColors.backgroundKup,
                    ),
                    SvgPicture.asset("assets/svg/success_card.svg"),
                    Positioned(
                      top: 128,
                      child: Text(
                        "Skriv ditt rabattkod",
                        style: AppStyle.tariff0,
                      ),
                    ),
                    Positioned(
                        top: 23,
                        right: 18,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/svg/close.svg")))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 23, left: 23),
                child: const Text(
                  "Kortet du angav verkar vara ogiltigt. Kontrollera dina kortuppgifter och försök igen, eller använd ett annat betalkort.",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: buttonLogin(
                    onPressed: () {
                      Navigator.pop(context);
                      onPressed();
                    },
                    label: "Försök igen",
                    isActive: true),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget bonusItem({required bool isActive, Function? onTap, String? title, String? price}) {
  return Container(
    height: 54,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(136)),
    margin: const EdgeInsets.only(top: 16, left: 40, right: 40),
    child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(136.0),
            ),
            side: BorderSide(color: isActive ? AppColors.green : AppColors.grey2)),
        onPressed: () {
          onTap!();
        },
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/success_progress1${isActive ? "on" : ""}.svg"),
            const SizedBox(width: 14),
            Text(title ?? "", style: AppStyle.promo),
            const Spacer(),
            Text(price ?? "", style: AppStyle.promo),
            const SizedBox(width: 29)
          ],
        )),
  );
}