import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';

void showCustomFlash(
  String message,
  BuildContext context,
  bool isSuccess, {
  FlashPosition position = FlashPosition.top,
  Alignment? alignment,
}) {
  showFlash(
    context: context,
    duration: Duration(milliseconds: isSuccess ? 2500 : 2500),
    builder: (context, controller) {
      return Flash.dialog(
          controller: controller,
          backgroundColor: isSuccess ? AppColors.green : AppColors.red,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular((16)), bottomRight: Radius.circular((16))),
          borderColor: Colors.transparent,
          alignment: Alignment.topCenter,
          onTap: () => controller.dismiss(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all((12.0)),
                  child: Text(
                    message,
                    style: AppStyle.progress.copyWith(fontSize: 17, color: AppColors.white, fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.dismiss();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ))
            ],
          ));
    },
  );
}
