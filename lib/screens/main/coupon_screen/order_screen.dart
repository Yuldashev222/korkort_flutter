import 'dart:ui';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/bloc/order_check/order_check_bloc.dart';
import 'package:korkort/screens/main/coupon_screen/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../bloc/order/order_bloc.dart';
import '../../tariff/widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderGetEvent());
  }

int page=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Orders",
          style: AppStyle.appBarStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/svg/exit.svg",
            color: AppColors.blackIntro,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Stack(
        children: [
          Positioned(
              child: CustomPaint(
            painter: MyPainter(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 110, sigmaX: 110),
              child: Container(
                height: 300.0,
              ),
            ),
          )),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is OrderLoaded) {
                return Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 24),
                    child: CustomRefreshIndicator(
                      onRefresh: () async {
                        page+=1;
                        context.read<OrderBloc>().add(OrderAddEvent(page: page));
                      },
                      trigger: IndicatorTrigger.trailingEdge,
                      trailingScrollIndicatorVisible: false,
                      leadingScrollIndicatorVisible: true,
                      child: SingleChildScrollView(
                        physics:const BouncingScrollPhysics(),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              "${state.day} Days",
                              style: AppStyle.couponMoney,
                            )),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(right: 24, left: 24),
                              child: Center(
                                child: Text(
                                  "Countdown to Your Prime Subscription Renewal!",
                                  textAlign: TextAlign.center,
                                  style: AppStyle.couponTitle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 62),
                            for (int i = 0; i < (state.ordersResponseList?.length ?? 0); i++)
                              couponButtonWidget(
                                  title: "${state.ordersResponseList?[i].tariffDays ?? 0} days plan",
                                  subtitle: state.ordersResponseList?[i].createdAt,
                                  titleTr: "${state.ordersResponseList?[i].purchasedPrice ?? 0} SEK",
                                  onTap: () {
                                    context.read<OrderCheckBloc>().add(OrderCheckGetEvent(id: state.ordersResponseList?[i].id));
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height - 100, // here increase or decrease in width
                                        ),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                        builder: (context) {
                                          return SizedBox(
                                              // height: MediaQuery.of(context).size.height * 0.9,
                                              child: couponBottomSheetCheck(onPressed: () {}));
                                        });
                                  }),
                           const SizedBox(height: 24)
                          ],
                        ),
                      ),
                      builder: (BuildContext context, Widget child, IndicatorController controller) {
                        return AnimatedBuilder(
                            animation: controller,
                            builder: (context, _) {
                              final dy = controller.value.clamp(0.0, 1.25) * -(150 - (150 * 0.25));
                              return Stack(
                                children: [
                                  Transform.translate(
                                    offset: Offset(0.0, dy),
                                    child: child,
                                  ),
                                  Positioned(
                                    bottom: -150,
                                    left: 0,
                                    right: 0,
                                    height: 150,
                                    child: Container(
                                      transform: Matrix4.translationValues(0.0, dy, 0.0),
                                      padding: const EdgeInsets.only(top: 30.0),
                                      constraints: const BoxConstraints.expand(),
                                      child: Column(
                                        children: [
                                          if (controller.isLoading)
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 8.0),
                                              width: 16,
                                              height: 16,
                                              child: const CircularProgressIndicator(
                                                color: AppColors.green,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          else
                                            const CircularProgressIndicator(
                                              color: AppColors.green,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ));
              }
              return const Center(child: CircularProgressIndicator(color: AppColors.green));
            },
          ),

        ],
      ),
    );
  }
}
