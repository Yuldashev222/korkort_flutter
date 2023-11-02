import 'dart:io';
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show get;
import 'package:korkort/bloc/payment/payment_bloc.dart';
import 'package:korkort/bloc/payment_stripe/payment_stripe_bloc.dart';
import 'package:korkort/screens/tariff/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:path_provider/path_provider.dart';

import '../../route/route_constants.dart';

class TariffScreen extends StatefulWidget {
  const TariffScreen({Key? key}) : super(key: key);

  @override
  State<TariffScreen> createState() => _TariffScreenState();
}

class _TariffScreenState extends State<TariffScreen> {
  bool isCoupon = false;

  String? userCode;
  FocusNode focusNode = FocusNode();
  bool isScroll = false;
  var imageData;
  bool dataLoaded = false;
  GetStorage getStorage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {

      if (focusNode.hasFocus) {
        setState(() {
          print('_TariffScreenState.initState');
          isScroll = true;
        });
      } else {
        setState(() {
          isScroll = false;
        });
      }
    });
    context.read<PaymentBloc>().add(TariffsEvent());
  }

  List tariffList = [];

  _downloadAndSavePhoto(String urlImage, String title) async {
    var url = urlImage;
    var response = await get(Uri.parse(url));

    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    await Directory(firstPath).create(recursive: true);
    var filePathAndName = '${documentDirectory.path}/images/pic.jpg';
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    setState(() {
      imageData = filePathAndName;
      getStorage.write("image_data", filePathAndName);
      dataLoaded = true;
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
          builder: (context) {
            return Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                child: bonusWidget(context: context, title: title, image: "", imageData: filePathAndName));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is TariffLoaded) {
            if (state.tariffResponse?.tariffDiscountImage == null) {
            } else if (getStorage.read("image_data") != null && getStorage.read("tariff_url") == state.tariffResponse?.tariffDiscountImage) {
              getStorage.write("tariff_url", state.tariffResponse?.tariffDiscountImage);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                  builder: (context) {
                    return Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                        child: bonusWidget(
                            context: context, title: state.tariffResponse?.tariffDiscountTitle, image: state.tariffResponse?.tariffDiscountImage, imageData: getStorage.read("image_data")));
                  });
            } else {
              getStorage.write("tariff_url", state.tariffResponse?.tariffDiscountImage);
              _downloadAndSavePhoto(state.tariffResponse?.tariffDiscountImage as String, state.tariffResponse?.tariffDiscountTitle as String);
            }
          }
        },
        builder: (context, state) {
          if (state is TariffLoaded) {
            return Container(
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
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 50),
                                  Text(
                                    "Din Körkortsresa Börjar Här!",
                                    style: AppStyle.appBarText1,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/on_progress_0.svg",
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
                                        "assets/svg/on_progress_1.svg",
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
                                        "assets/svg/status.svg",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 5,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 24),
                                        child: Text(
                                          "Välj paket",
                                          style: AppStyle.tariff,
                                        ),
                                      ),
                                      // const SizedBox(width: 5),
                                      Container(
                                        padding: const EdgeInsets.only(left: 22,right: 22,top: 5,bottom: 5),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            backgroundColor: AppColors.greenAccent,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                builder: (context) {
                                                  return Container(
                                                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                      height: isScroll ? MediaQuery.of(context).size.height * 0.8 :
                                                      MediaQuery.of(context).size.height * 0.7,
                                                      child: Show(
                                                        isBonus: true,
                                                        isIsland: true,
                                                        focusNode: focusNode,
                                                        title: "Din balans",
                                                        price: state.tariffResponse?.studentBonusMoney,
                                                        priceCoupon: state.tariffResponse?.studentDiscountValue ?? 0,
                                                        isPercent: state.tariffResponse?.studentDiscountIsPercent,
                                                        functionCoupon: (coupon, userCodeC) {
                                                          setState(() {
                                                            isCoupon = coupon;
                                                            userCode = userCodeC;
                                                          });
                                                        },
                                                        successCoupon: (i) {
                                                          setState(() {
                                                            isScroll=!isScroll;
                                                          });

                                                        },
                                                      ));
                                                });
                                          },
                                          child: Center(
                                            child: Text(
                                              "Rabattkod",
                                              style: AppStyle.loginButton,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 19),
                                  for (int i = 0; i < state.tariffResponse!.objects!.length; i++)
                                    Column(
                                      children: [
                                        tariffItemDiscount(
                                            onTap: () {
                                              setState(() {
                                                tariffList.clear();
                                                tariffList.add(i);
                                              });
                                            },
                                            isActive: tariffList.contains(i) ? true : false,
                                            day: (state.tariffResponse?.objects?[i].days??0).toString(),
                                            price: (state.tariffResponse?.objects?[i].price)! -
                                                ((state.tariffResponse?.objects?[i].tariffDiscountAmount) ?? 0) -
                                                (isCoupon ? (state.tariffResponse?.objects?[i].studentDiscountAmount ?? 0) : 0),
                                            days: state.tariffResponse?.objects?[i].days.toString(),
                                            discountPrice: isCoupon
                                                ? ((state.tariffResponse?.studentDiscountIsPercent ?? false)
                                                ? (state.tariffResponse?.studentDiscountValue ?? 0)
                                                : (state.tariffResponse?.objects?[i].studentDiscountAmount ?? 0))
                                                : null,
                                            discountPriceAll: (state.tariffResponse?.objects?[i].price),
                                            isPercent: state.tariffResponse?.studentDiscountIsPercent,
                                            studentDiscount: state.tariffResponse?.objects?[i].studentDiscount),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
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
                                        const SizedBox(width: 46),
                                        Flexible(
                                          // width: 228,
                                          child: buttonLogin(
                                            onPressed: () {
                                              if (tariffList.isNotEmpty) {
                                                context
                                                    .read<PaymentStripeBloc>()
                                                    .add(PaymentStripeCreateEvent(useBonusMoney: isCoupon, userCode: userCode, tariffId: state.tariffResponse!.objects![tariffList[0]].id));
                                                Navigator.pushNamed(context, RouteList.webViewScreen);
                                              }
                                            },
                                            label: "Kör Framåt till Kassan!",
                                            isActive: tariffList.isNotEmpty,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
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
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          );
        },
      ),
    );
  }
}
