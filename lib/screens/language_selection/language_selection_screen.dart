import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/language_selection/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';

import '../../bloc/language/language_bloc.dart';
import '../../widgets/button_login.dart';
import '../tariff/widget.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
 String? language;
  GetStorage getStorage = GetStorage();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LanguageBloc>().add(LanguageGetEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is LanguageLoaded){
            return Container(
              decoration: const BoxDecoration(
                  color: AppColors.whiteAccent
              ),
              child: Stack(
                children: [
                  Positioned(
                      right: 83,
                      left: 0,
                      child: CustomPaint(
                        painter: MyPainter(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 130, sigmaX: 130),
                          child: const SizedBox(
                            height: 200.0,
                            width: 200,
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: SvgPicture.asset("assets/svg/logo.svg"),
                        ),),
                      Expanded(
                        flex: 7,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [BoxShadow(color: AppColors.shadowColor, offset: Offset(0, 10))],
                            color: AppColors.white,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 40,),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: Text("Select Your Preferred Language", style: AppStyle.appBarText1,),
                              ),
                              // const SizedBox(height: 20),
                              Expanded(child: SingleChildScrollView(
                                physics:const BouncingScrollPhysics(),
                                child: Column(
                                children: [
                                 const SizedBox(height: 20),
                                  for(int i=0;i<state.languageResponse!.length;i++)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0,left: 24,right: 24),
                                      child: languageButtonItemWidget(
                                          onTap: () {
                                            setState(() {
                                              language=state.languageResponse?[i].languageId;
                                            });
                                          },
                                          isActive: language==state.languageResponse?[i].languageId,
                                          assetsName: "flag",
                                          languageName: state.languageResponse?[i].name??""),
                                    ),
                                ],
                              ),)),

                              const SizedBox(height: 90),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,right: 24,
                    child:  buttonLogin(
                      onPressed: () async {
                        if (language!=null) {
                            await getStorage.write("language", language);
                          Navigator.pushNamed(context, RouteList.infoScreen);
                        }
                      },
                      label: "FORTSÄTTT",
                      isActive: language!=null)
                    ,)
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator(color: AppColors.green,),);
        },
      ),
    );
  }
}
