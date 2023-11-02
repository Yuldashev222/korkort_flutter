import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';

import '../../../bloc/order_check/order_check_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../pdf_generate.dart';
Widget couponButtonWidget({String? title, String? subtitle, String? titleTr, Function? onTap}) {
  DateTime date = DateFormat("yyyy-MM-dd hh:mm").parse(subtitle ?? '');
  // String dateString =((date.day.toString())+(date.month.toString())+(date.year.toString())) ;
  String dateString = DateFormat('d MMM yyyy').format(date);

  return Padding(
    padding: const EdgeInsets.only(bottom: 14.0),
    child: InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        // height: 66,
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.white),
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/coupon_button.svg"),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: AppStyle.couponButtonTitle,
                ),
                Text(
                  dateString ?? "",
                  style: AppStyle.couponButtonSubtitle,
                ),
              ],
            ),
            const Spacer(),
            Text(
              titleTr ?? "",
              style: AppStyle.couponButtonTr,
            )
          ],
        ),
      ),
    ),
  );
}

Widget couponBottomSheetCheck({Function? onPressed}) {


  return BlocConsumer<OrderCheckBloc, OrderCheckState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state)  {
      if (state is OrderCheckLoaded) {
        num totalTariff = state.results?.tariffPrice ?? 0;
        num rabat = (state.results?.tariffDiscountAmount ?? 0) + (state.results?.studentDiscountAmount ?? 0) + (state.results?.studentBonusAmount ?? 0);
        num subtotal = (totalTariff - rabat) * 0.75;
        num moms = (totalTariff - rabat) * 0.25;
        num total = totalTariff - rabat;

        // pdf.addPage(pw.Page(
        //     pageFormat: PdfPageFormat.a4,
        //     build: (pw.Context context) {
        //       return pw.Padding(
        //         padding: const pw. EdgeInsets.only(right: 24.0, left: 42),
        //         child: pw.Column(
        //           children: [
        //              pw.SizedBox(height: 46),
        //             pw.Image(imagePro()),
        //             pw.SizedBox(height: 23),
        //             pw.Text("Receipt", style:pw.TextStyle(
        //               fontSize: 28,
        //               // fontWeight: pw.FontWeight,
        //               // color: pw.Color(0xFF27364E),
        //               fontFamily: "Manrope",
        //             ) ),
        //             pw.Text(
        //               "Ditt Kvitto Syns Nedan. Nu är det Dags att Kasta Loss och Studera!",
        //               style: AppStyle.couponTitleCheck,
        //               textAlign: TextAlign.center,
        //             ),
        //             const SizedBox(height: 43),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "${state.results?.tariffDays} dagars paket allt ingår",
        //                       style: AppStyle.checkStyle,
        //                     ),
        //                     Text(
        //                       "Beställnings nr: #${state.results?.orderId}",
        //                       style: AppStyle.check12,
        //                     ),
        //                   ],
        //                 ),
        //                 Text(
        //                   "${state.results?.tariffPrice ?? 0}kr",
        //                   style: AppStyle.checkStyle,
        //                 )
        //               ],
        //             ),
        //             const SizedBox(height: 19),
        //             const Divider(color: Color.fromRGBO(62, 62, 62, 0.10), height: 1),
        //             const SizedBox(height: 19),
        //             if (rabat > 0)
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text("Rabatt", style: AppStyle.checkStyle),
        //                   Text("-${rabat}kr", style: AppStyle.checkStyle),
        //                 ],
        //               ),
        //             const SizedBox(height: 2),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("Subtotal", style: AppStyle.checkStyle),
        //                 Text("$subtotal kr", style: AppStyle.checkStyle),
        //               ],
        //             ),
        //             const SizedBox(height: 2),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("Moms", style: AppStyle.checkStyle),
        //                 Text("$moms kr", style: AppStyle.checkStyle),
        //               ],
        //             ),
        //             const SizedBox(height: 19),
        //             const Divider(color: Color.fromRGBO(62, 62, 62, 0.10), height: 1),
        //             const SizedBox(height: 20),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("Total", style: AppStyle.total),
        //                 Text("$total kr", style: AppStyle.total),
        //               ],
        //             ),
        //             const SizedBox(height: 65),
        //             buttonLogin(
        //                 onPressed: () {
        //                   onPressed!();
        //                 },
        //                 label: "Download",
        //                 isActive: true)
        //           ],
        //         ),
        //       ); // Center
        //     })); //

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24),
            child: Column(
              children: [
                const SizedBox(height: 46),
                SvgPicture.asset("assets/svg/coupon_check.svg"),
                const SizedBox(height: 23),
                Text("Receipt", style: AppStyle.check),
                Text(
                  "Ditt Kvitto Syns Nedan. Nu är det Dags att Kasta Loss och Studera!",
                  style: AppStyle.couponTitleCheck,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 43),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${state.results?.tariffDays} dagars paket allt ingår",
                          style: AppStyle.checkStyle,
                        ),
                        Text(
                          "Beställnings nr: #${state.results?.orderId}",
                          style: AppStyle.check12,
                        ),
                      ],
                    ),
                    Text(
                      "${state.results?.tariffPrice ?? 0}kr",
                      style: AppStyle.checkStyle,
                    )
                  ],
                ),
                const SizedBox(height: 19),
                const Divider(color: Color.fromRGBO(62, 62, 62, 0.10), height: 1),
                const SizedBox(height: 19),
                if (rabat > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rabatt", style: AppStyle.checkStyle),
                      Text("-${rabat}kr", style: AppStyle.checkStyle),
                    ],
                  ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal", style: AppStyle.checkStyle),
                    Text("$subtotal kr", style: AppStyle.checkStyle),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Moms", style: AppStyle.checkStyle),
                    Text("$moms kr", style: AppStyle.checkStyle),
                  ],
                ),
                const SizedBox(height: 19),
                const Divider(color: Color.fromRGBO(62, 62, 62, 0.10), height: 1),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: AppStyle.total),
                    Text("$total kr", style: AppStyle.total),
                  ],
                ),
                const SizedBox(height: 65),
                buttonLogin(
                    onPressed: () {
                      onPressed!();
                      Navigator.pop(context);
                      openFile(codeItem: state.results?.orderId,day:state.results?.tariffDays ,price: state.results?.tariffPrice ?? 0,rabat: rabat,subtotal:subtotal ,moms: moms,total:total );

                    },
                    label: "Download",
                    isActive: true),
               const SizedBox(height: 50)
              ],
            ),
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.green,
        ),
      );
    },
  );
}
