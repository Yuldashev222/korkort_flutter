import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteGrey,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset("assets/svg/left.svg"),
        ),
        centerTitle: true,
        title: Text("Privacy policy", style: AppStyle.appBarStylePrivacy),
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for(int i=0;i<10;i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Types of Data We Collect",
                    style: AppStyle.appBarStylePrivacy,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of "
                    "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    style: AppStyle.privacyTitle,
                  ),
                  const SizedBox(height: 24)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
