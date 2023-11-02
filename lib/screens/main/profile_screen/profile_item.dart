import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';

import '../../../bloc/language/language_bloc.dart';
import '../../../style/app_colors.dart';
import '../../language_selection/widget.dart';

List profileList = ["Edit Profile", "Orders", "Driving license guide", "Coupons", "Language", "Settings", "Level achievements", "Support", "Logout"];

Widget profileItem({int? i, Function? onTap, bool? isLanguage}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: SizedBox(
      height: 48,
      child: Row(
        children: [
          SvgPicture.asset("assets/svg/profile_icon$i.svg"),
          const SizedBox(width: 16),
          Text(profileList[i ?? 0], style: AppStyle.profileItem),
          const Spacer(),
          if (isLanguage ?? false) const Text("English(US)"),
          if (isLanguage ?? false) const SizedBox(width: 25),
          SvgPicture.asset("assets/svg/arrow_right1.svg"),
        ],
      ),
    ),
  );
}

Widget bottomSheetProfileUpdate({Function?onPressed,}) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    // height: 300,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          SvgPicture.asset("assets/svg/profile_update.svg"),
          const SizedBox(height: 12),
          Text("Profile Updated!", style: AppStyle.check),
          const SizedBox(height: 12),
          Text(
            "Your profile detail has been updated, changes already reflected in the profile page.",
            style: AppStyle.check1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: buttonLogin(
                onPressed: () {
                  onPressed!();
                },
                label: "Confirm",
                isActive: true),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    ),
  );
}

Widget bottomSheetCustom({Function?onPressed, String?icon, String?title, String?desc}) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    // height: 300,
    padding: const EdgeInsets.only(left: 24, right: 24),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          SvgPicture.asset("assets/svg/$icon.svg"),
          const SizedBox(height: 12),
          Text(title ?? "", style: AppStyle.check, textAlign: TextAlign.center,),
          const SizedBox(height: 12),
          Text(desc ?? "", style: AppStyle.check1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: buttonLogin(
                onPressed: () {
                  onPressed!();
                },
                label: "Close",
                isActive: false),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    ),
  );
}

Widget bottomSheetLogout({Function? onPressed}) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    // height: 300,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          SvgPicture.asset("assets/svg/logout.svg"),
          const SizedBox(height: 12),
          Text("Are You Sure?", style: AppStyle.check),
          const SizedBox(height: 12),
          Text(
            "Are you sure you want to logout from this account? you can loging back in easily.",
            style: AppStyle.check1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: buttonLogin(
                onPressed: () {
                  onPressed!();
                },
                label: "Confirm",
                isActive: true),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: buttonLoginLogout(
                onPressed: () {
                  onPressed!();
                },
                label: "Logout",
                isActive: false),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    ),
  );
}


class BottomSheetLanguageChange extends StatefulWidget {
  const BottomSheetLanguageChange({Key? key}) : super(key: key);

  @override
  State<BottomSheetLanguageChange> createState() => _BottomSheetLanguageChangeState();
}

class _BottomSheetLanguageChangeState extends State<BottomSheetLanguageChange> {
String? language;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LanguageBloc>().add(LanguageGetEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      // height: 300,
      child: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is LanguageLoaded){
            return Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 4,
                    width: 66,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: AppColors.bottomSheetTop,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 18),
                          Text("Select Language", style: AppStyle.check),
                          const SizedBox(height: 24),
                          for(int i = 0; i < state.languageResponse!.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: languageButtonChangeProfile(onTap: () {
                                setState(() {
                                 language=state.languageResponse?[i].languageId;
                                });
                              }, isActive: language==state.languageResponse?[i].languageId,
                                  assetsName: "flag1", languageName: state.languageResponse?[i].name??""),
                            ),
                          const SizedBox(height: 8),
                          buttonLogin(
                              onPressed: () async{
                               await GetStorage().write("language",language);
                                Navigator.pop(context);
                              },
                              label: "Select",
                              isActive: true),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator(color: AppColors.green,),);
        },
      ),
    );
  }
}

class DeployImageEditeProfileScreen extends StatefulWidget {
  final Map dataInfo;

  const DeployImageEditeProfileScreen({Key? key, required this.dataInfo}) : super(key: key);

  @override
  State<DeployImageEditeProfileScreen> createState() => _DeployImageEditeProfileScreenState();
}

class _DeployImageEditeProfileScreenState extends State<DeployImageEditeProfileScreen> {
  bool isActive = false;
  int avatarItem = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            height: 4,
            width: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: AppColors.bottomSheetTop,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                (avatarItem != 0 && avatarItem >= 1)
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/avatar.svg", height: 120, width: 120,),
                    SvgPicture.asset(
                      "assets/svg_avatar/avatar$avatarItem.svg",
                      height: 100, width: 100,
                    ),
                  ],
                )
                    : Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/avatar.svg", height: 120, width: 120,),
                    SvgPicture.asset("assets/svg/deploy_svg.svg", height: 100, width: 100,),
                  ],
                ),

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 35; i++)
                        Container(
                          margin: const EdgeInsets.only(left: 14),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                avatarItem = i;
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/svg_avatar/avatar$i.svg",
                              height: 80,
                              width: 80,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  width: double.infinity,
                  child: buttonLogin(
                      onPressed: () {
                        if ((avatarItem != 0 && avatarItem >= 1)) {
                          // Navigator.pushNamed(context, RouteList.mainScreen, arguments: avatarItem);
                        }
                      },
                      label: "Confirm",
                      isActive: (avatarItem != 0 && avatarItem >= 1)),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
