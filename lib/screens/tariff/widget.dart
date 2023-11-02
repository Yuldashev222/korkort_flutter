import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/app_colors.dart';
import '../../style/app_style.dart';

Widget tariffItem({required Function onTap, required bool isActive, String? price, String? day, String? days}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        border: Border.all(
          color: isActive ? AppColors.greenAccent : Colors.transparent,
          width: 1,
        ),
        // border: OutlinedBorder(side: BorderSide()),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorLanguage.withOpacity(0.1),
            offset: const Offset(0, 0.12),
            spreadRadius: 5, //spread radius
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 15, left: 20, right: 28),
            child: isActive ? SvgPicture.asset("assets/svg/check2.svg") : SvgPicture.asset("assets/svg/check1.svg"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 9),
              Row(
                children: [
                  Text(
                    "$price kr/ ",
                    style: AppStyle.tariff0,
                  ),
                  Text(
                    "${day} dagar",
                    style: AppStyle.tariff1,
                  ),
                ],
              ),
              Text(
                "Allt ingår i $days dagar",
                style: AppStyle.tariffSubtitle,
              ),
              const SizedBox(height: 9),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget tariffItemDiscount({required Function onTap, required bool isActive, num? price, String? day, String? days, num? discountPrice, num? discountPriceAll, bool? isPercent,
  bool?studentDiscount}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        border: Border.all(
          color: isActive ? AppColors.greenAccent : Colors.transparent,
          width: 1,
        ),
        // border: OutlinedBorder(side: BorderSide()),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorLanguage.withOpacity(0.1),
            offset: const Offset(0, 0.12),
            spreadRadius: 5, //spread radius
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 15, left: 20, right: 28),
            child: isActive ? SvgPicture.asset("assets/svg/check2.svg") : SvgPicture.asset("assets/svg/check1.svg"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 9),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(discountPriceAll != null && price! < discountPriceAll ? "$discountPriceAll kr" : "", style: AppStyle.discountPrice)
                ],
              ),
              Row(
                children: [
                  Text(
                    "$price kr/ ",
                    style: AppStyle.tariff0,
                  ),
                  Text(
                    "$day dagar",
                    style: AppStyle.tariff1,
                  ),
                ],
              ),
              Text(
                "Allt ingår i $days dagar",
                style: AppStyle.tariffSubtitle,
              ),
              const SizedBox(height: 9),
            ],
          ),
          const Spacer(),
          Text(
            discountPrice != null && discountPrice > 0 &&(studentDiscount??false) ? "-$discountPrice ${isPercent ?? false ? "%" : "kr"}" : "",
            style: AppStyle.discount,
          ),
          const SizedBox(width: 20)
        ],
      ),
    ),
  );
}
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff94D073);
    path = Path();
    path.lineTo(size.width * 0.92, 0);
    path.cubicTo(size.width * 0.92, size.height * 0.17, size.width * 0.83, size.height * 0.69, size.width * 0.64, size.height * 0.69);
    path.cubicTo(size.width * 0.54, size.height * 0.69, size.width * 0.57, size.height * 0.48, size.width * 0.36, size.height * 0.3);
    path.cubicTo(size.width * 0.16, size.height * 0.12, -0.08, 0, -0.08, -0.09);
    path.cubicTo(-0.08, -0.26, size.width * 0.37, -0.31, size.width * 0.57, -0.31);
    path.cubicTo(size.width * 0.76, -0.31, size.width * 0.92, -0.17, size.width * 0.92, 0);
    path.cubicTo(size.width * 0.92, 0, size.width * 0.92, 0, size.width * 0.92, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
