import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/bloc/profile/profile_bloc.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/main/profile_screen/profile_item.dart';
import 'package:korkort/style/app_colors.dart';

import '../../../style/app_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(ProfileGetEvent());
  }
  ProfileResponse profileResponse=ProfileResponse();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
             const SizedBox(height: 10),
              Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin:const EdgeInsets.only(top: 72),
                      // height: double.infinity,
                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)), color: AppColors.white),
                      child: Column(
                        children: [
                          const   SizedBox(height: 72),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RouteList.tariffScreen);
                            },
                            child: Container(
                              // height: 71,
                              margin:const EdgeInsets.only(left: 20,right: 20,bottom: 28),
                              padding:const EdgeInsets.only(left:34,top: 18,bottom: 18,right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.green
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/svg/carona.svg",height: 35,width: 43,),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Join Our Premium",style: AppStyle.tariffGo),
                                      Text("Unlimited Features",style: AppStyle.subGoTariff,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          for (int i = 0; i < 9; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 14),
                              child: profileItem(
                                  i: i,
                              isLanguage: i == 4,
                              onTap: () {
                                if (i == 0) {
                                  Navigator.pushNamed(context, RouteList.editeProfileScreen, arguments: profileResponse).then((value) {
                                    context.read<ProfileBloc>().add(ProfileGetEvent());
                                    setState(() {});
                                  });
                                } else if (i == 1) {
                                  Navigator.pushNamed(context, RouteList.orderScreen).then((value) {
                                    setState(() {});
                                  });
                                } else if (i == 3) {
                                  Navigator.pushNamed(context, RouteList.couponMainScreen);
                                } else if (i == 4) {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                      builder: (context) {
                                        return SizedBox(height: MediaQuery.of(context).size.height * 0.7, child: const BottomSheetLanguageChange());
                                      });
                                } else if (i == 8) {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                      builder: (context) {
                                        return SizedBox(
                                            // height: MediaQuery.of(context).size.height * 0.6,
                                            child: bottomSheetLogout(onPressed: () {
                                          GetStorage().remove("token");
                                          Navigator.pushNamedAndRemoveUntil(context, RouteList.authScreen, (route) => false, arguments: 1);
                                        }));
                                      });
                                } else if (i == 2) {
                                  Navigator.pushNamed(context, RouteList.todoUp);
                                } else if (i == 6) {
                                  Navigator.pushNamed(context, RouteList.level);
                                }
                              }),
                            )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 0,
                        height: 144,
                        width: 144,

                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: 77,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: BlocConsumer<ProfileBloc, ProfileState>(
                              listener: (context, state) {
                                if(state is ProfileLoaded){
                                  profileResponse=state.profileResponse!;
                                }
                              },
                              builder: (context, state) {
                                if(state is ProfileLoaded){

                                  return SvgPicture.asset("assets/svg_avatar/avatar${state.profileResponse?.avatarId??0}.svg");
                                }
                                return SvgPicture.asset("assets/svg_avatar/avatar${GetStorage().read("avatarItem") ?? 0}.svg");
                              },
                            ),
                          ),
                        )
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
