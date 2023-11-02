import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../route/route_constants.dart';
import '../../widgets/button_login.dart';

class DeployImageScreen extends StatefulWidget {
  final Map dataInfo;

  const DeployImageScreen({Key? key, required this.dataInfo}) : super(key: key);

  @override
  State<DeployImageScreen> createState() => _DeployImageScreenState();
}

class _DeployImageScreenState extends State<DeployImageScreen> {
  bool isActive = false;
  int avatarItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if(state is ProfileUpdateLoaded){
            Navigator.pushNamedAndRemoveUntil(context, RouteList.mainScreen, (route) => false);
          } else if(state is ProfileError){
            print('_DeployImageScreenState.build Error');
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.1, 0.9, 0.6, 0.2],
                colors: [
                  AppColors.whiteAccent,
                  AppColors.greenAccent.withOpacity(0.7),
                  AppColors.whiteAccent,
                  AppColors.whiteAccent,
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35,bottom: 24,top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Din Körkortsresa Börjar Här!",
                            style: AppStyle.appBarText1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Var vänlig ange ditt fullständiga namn, din e-postadress och välj ett lösenord.",
                            style: AppStyle.appBarText2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 8,
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
                    child: Container(
                      // padding: const EdgeInsets.only(
                      //   left: 24,
                      //   right: 24,
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          // const SizedBox(height: 84),
                          (avatarItem >= 0)
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
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              "${widget.dataInfo["first_name"]??""}",
                              style: AppStyle.imageName,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.dataInfo["email"]??"",
                              style: AppStyle.subtitleName,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 67),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < 33; i++)
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
                                    context.read<ProfileBloc>().add(ProfileUpdateNoPasswordEvent(avatar:avatarItem,lastName: widget.dataInfo["last_name"],firstName: widget
                                        .dataInfo["first_name"]));
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
