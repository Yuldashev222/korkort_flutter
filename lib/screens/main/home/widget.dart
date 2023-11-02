import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../../widgets/button_login.dart';

Widget lessonButton({required int index, String? name, num? time, bool? isCompleted, bool? isOpen, Function? onTap, int? lessonPermissionId, int? onlineId, int? id, bool? isActive}) {
  NumberFormat formatter = NumberFormat("00");

  return Container(
    padding: EdgeInsets.only(left: isActive ?? false ? 0 : 19, bottom: 10.0),
    child: Container(
      // height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive ?? false ? AppColors.green : AppColors.white,
          boxShadow:  [
              isActive ?? false? const BoxShadow(
              color: AppColors.buttonShadow,
              spreadRadius: 2,
              blurRadius: 2
            ): const BoxShadow(
                  color: AppColors.buttonShadow,
                  spreadRadius: 1,
                  blurRadius: 1
              ),

          ]
      ),
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        onPressed: (){
          if (onlineId != id) {
            onTap!();
          }
        },
        child: Row(
          children: [
           const SizedBox(width: 16),
            Text(formatter.format(index), style:isActive??false? AppStyle.lessonButton:AppStyle.lessonButtonNGrey),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 13),
                  Text(
                    name ?? "",
                    style: isActive ?? false ? AppStyle.lessonButton1 : AppStyle.lessonButtonGrey,
                    maxLines: 1,
                  ),
                  Text("$time Minutes", style: isActive ?? false ? AppStyle.lessonButton2 : AppStyle.lessonButton2Grey),
                  const SizedBox(height: 13),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(24),
                    boxShadow:  [
                      BoxShadow(
                          color: AppColors.categoryGrey.withOpacity(0.5),
                          blurRadius: 1.0,
                          offset: Offset(0.0, 1.5),
                          spreadRadius: 0.0)
                    ]
                ),
                child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.white,
                    child: Center(
                        child: onlineId == id
                            ? const Icon(
                                Icons.pause,
                                color: AppColors.blackIntro,
                              )
                            : lessonPermissionId == 2
                                ? const Icon(
                                    Icons.play_arrow,
                                    color: AppColors.blackIntro,
                                  )
                                : lessonPermissionId == 4
                                    ? SvgPicture.asset(
                                        "assets/svg/carona.svg",
                                        // color: AppColors.yellow,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/lock.svg",
                                        color: AppColors.lock,
                                      ))),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    ),
  );
}

Widget testItem({Function? onTap, int? index, int? item, String? title, bool? isTrue}) {
  return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 25, right: 25),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 13, bottom: 13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(51, 51, 51, 0.05),
                offset: Offset(10, 24),
                blurRadius: 54,
                spreadRadius: 0,
              ),
            ],
            color: (index == item ? ((isTrue ?? true) ? AppColors.testSuccess : AppColors.testError) : AppColors.white),
            border: Border.all(color: (index == item ? ((isTrue ?? true) ? AppColors.testGreen : AppColors.testError) : AppColors.testSuccess))),
        child: Row(
          children: [
            if (index != item)
              SvgPicture.asset(
                "assets/svg/test_circle.svg",
                color: AppColors.circle,
              ),
            if (index == item)
              if (isTrue == null)
                SvgPicture.asset(
                  "assets/svg/test_circle.svg",
                  color: index == item ? AppColors.testGreen : AppColors.circle,
                ),
            if (index == item)
              if (isTrue == false)
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.testErrorIcon,
                  child: SvgPicture.asset(
                    "assets/svg/error.svg",
                  ),
                ),
            if (index == item)
              if (isTrue == true)
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/svg/check.svg",
                  ),
                ),
            const SizedBox(width: 16),
            Expanded(child: Text(title ?? "", style: AppStyle.testCheck)),
          ],
        ),
      ));
}
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

Widget bottomSheetGoTariff({Function? onTap, Function? onTapExit, required BuildContext? context}) {
  List titleList = [
    "Få tillgång till 1500? körkortsfrågor",
    "Lär dig med våra mest populära",
    "Lyssna på vår audiobok vart du än är",
    "Rekommenderar av trafikskolor",
    "Tillgång till vår webbsida och mobilapp"
  ];
  return SafeArea(
    child: Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)), color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 34.0, right: 34),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset("assets/svg/lock_t.svg"),
              const SizedBox(height: 16),
              Text("Upgrade to PRO", style: AppStyle.check),
              Text(
                "New payment method successfully registered, you can donate using this card now.",
                style: AppStyle.check1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 29),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/svg/success.svg"),
                      const SizedBox(width: 10),
                      Text(
                        titleList[i],
                        style: AppStyle.goTariff,
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 34),
              buttonLogin(
                  onPressed: () {
                    onTap!();
                  },
                  label: "Kör Framåt till Kassan!",
                  isActive: true),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context!);
                  },
                  child: Text(
                    "Close window",
                    style: AppStyle.closeWindow,
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    ),
  );
}
Widget bottomSheetGo({Function? onTap, Function? onTapExit, required BuildContext? context}) {
  List titleList = [
    "Få tillgång till 1500? körkortsfrågor",
    "Lär dig med våra mest populära",
    "Lyssna på vår audiobok vart du än är",
    "Rekommenderar av trafikskolor",
    "Tillgång till vår webbsida och mobilapp"
  ];
  return SafeArea(
    child: Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)), color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 34.0, right: 34),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset("assets/svg/sucess_final.svg"),
              const SizedBox(height: 16),
              Text("Slutprov", style: AppStyle.check),
              Text(
                "New payment method successfully registered, you can donate using this card now.",
                style: AppStyle.check1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 29),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/svg/success.svg"),
                      const SizedBox(width: 10),
                      Text(
                        titleList[i],
                        style: AppStyle.goTariff,
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 34),
              buttonLogin(
                  onPressed: () {
                    onTap!();
                  },
                  label: "Starta slutprov",
                  isActive: true),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context!);
                  },
                  child: Text(
                    "No thanks",
                    style: AppStyle.closeWindow,
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    ),
  );
}
