import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/bloc/profile/profile_bloc.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/main/success/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../bloc/categories_exams/categories_exams_bloc.dart';
import '../../../bloc/categories_filter/categories_filter_bloc.dart';
import '../../../style/app_style.dart';
import '../../tariff/widget.dart';
import '../home/widget.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  double progress = 0;
  double currentSliderValue = 0;
  double sval2 = 0;
  Map data = {};
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            if (GetStorage().read("level") != state.profileResponse?.levelId) {
              GetStorage().write("level", state.profileResponse?.levelId);
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 73),
                            Padding(
                              padding: const EdgeInsets.only(left: 92, right: 92),
                              child: Center(
                                child: SvgPicture.asset("assets/svg_level/level${state.profileResponse?.levelId}.svg",width: 186,height: 70,),
                              ),
                            ),
                            const SizedBox(height: 27),
                            Text("🎉 Level Up! 🎉",style: AppStyle.level,),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30,bottom: 32),
                              child: Center(
                                child: Text("Congratulations, ${state.profileResponse?.firstName??""} ${state.profileResponse?.lastName??""}! You’ve advanced to Level ${state.profileResponse?.level??""} with a"
                                    " total of ${state.profileResponse?.ball??""}",
                                  textAlign:
                                TextAlign.center,style:
                                AppStyle
                                    .level1,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: buttonLogin(onPressed: (){
                                Navigator.pop(context);
                              }, label: "Next Adventure", isActive: true),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: AppColors.whiteAccent),
          child: Stack(
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
            BlocConsumer<CategoriesExamsBloc, CategoriesExamsState>(
              listener: (context, state) {
                if (state is CategoriesExamsLoaded) {
                  progress = (state.profileResponse?.levelPercent ?? 0) / 100;
                    for (int i = 0; i < (state.categoriesExamsResponse?.categoryExams?.length ?? 0); i++) {
                      data.addAll({
                        (state.categoriesExamsResponse?.categoryExams?[i].category.toString() ?? ""): {
                          "correct": [],
                          "wrong": [],
                          "name": (state.categoriesExamsResponse?.categoryExams?[i].name ?? "")
                        },
                      });
                    }
                    if ((state.categoriesExamsResponse?.categoryExams?.length ?? 0) > 0) {}
                    GetStorage().write("level", state.profileResponse?.levelId);
                  }
              },
              builder: (context, state) {
                if (state is CategoriesExamsLoaded) {
                  return Column(
                    children: [
                      const SizedBox(height: 58),
                      Container(
                        margin: const EdgeInsets.only(right: 24, left: 24),
                          padding: const EdgeInsets.only(left: 9, right: 9, top: 1, bottom: 1),
                          width: double.infinity,
                          // height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/svg_avatar/avatar${state.profileResponse?.avatarId ?? 0}.svg",
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: LayoutBuilder(builder: (context, c) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  state.profileResponse?.firstName ?? '',
                                                  style: AppStyle.nameAvatar,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.green),
                                                child:DateTime.parse(state.profileResponse!.tariffExpireDate!).isBefore(DateTime.now())?Center(
                                                  child: InkWell(
                                                    onTap: (){
                                                      showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                          builder: (context) {
                                                            return Container(
                                                              // margin: const EdgeInsets.only(top: 30),
                                                                decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                                // height: MediaQuery.of(context).size.height ,
                                                                child: bottomSheetGoTariff(
                                                                    onTap: () {
                                                                      Navigator.pushNamed(context, RouteList.tariffScreen);
                                                                    },
                                                                    onTapExit: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                    context: context));
                                                          });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset("assets/svg/corona_1.svg"),
                                                        const SizedBox(width: 2),
                                                        Text(
                                                          "Get premium",
                                                          style: AppStyle.levelProfile,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ):Center(child:Text(
                                                  state.profileResponse?.level ?? "",
                                                  style: AppStyle.levelProfile,
                                                ),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AnimatedContainer(
                                          padding: const EdgeInsets.all(0),
                                          width: c.maxWidth * progress >= 67 ? (c.maxWidth * progress)-10 : 67,
                                          alignment: Alignment.bottomRight,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.linear,
                                          child: Image.asset(
                                            "assets/png/car.png",
                                            width: 67,
                                            height: 26,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: c.maxWidth-30,
                                              child: RotatedBox(
                                                quarterTurns: 0,
                                                child: LinearPercentIndicator(
                                                  padding: const EdgeInsets.all(0),
                                                  animation: true,
                                                  lineHeight: 7.0,
                                                  animationDuration: 500,
                                                  percent: progress == 0 ? 0.02 : progress,
                                                  backgroundColor: AppColors.sliderDivider1,
                                                  barRadius: const Radius.circular(10),
                                                  progressColor: AppColors.greenAccent,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${(state.profileResponse?.levelPercent ?? 0).toInt()}%",
                                              style: AppStyle.progress,
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                  );
                                }),
                              )
                            ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24, right: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 82,
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.mainWhite,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Poäng",
                                                  style: AppStyle.mainStyle,
                                                ),
                                                Text(
                                                  "${state.profileResponse?.ball ?? 0}",
                                                  style: AppStyle.mainStyleProgress,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            height: 82,
                                            // width: double.infinity,
                                            padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.mainWhite,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Kapitel",
                                                  style: AppStyle.mainStyle,
                                                ),
                                                Text(
                                                  "${state.profileResponse?.correctAnswers ?? 0}/${state.profileResponse?.allQuestionsCount ?? 0}",
                                                  style: AppStyle.mainStyleProgress,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            height: 82,
                                            // width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.mainWhite,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Redo",
                                                  style: AppStyle.mainStyle,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${(state.profileResponse?.lastExamsResult ?? 0).toInt()}%",
                                                      style: AppStyle.mainStyleRedProgress,
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          progressVerticalCategories(context: context, detail: state.profileResponse?.lastExams);
                                                        },
                                                        child: SvgPicture.asset('assets/svg/i.svg', width: 15, height: 15))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 24, right: 24),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Träningsprov",
                                              style: AppStyle.sub2,
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, RouteList.categoriesScreen);
                                              },
                                              child: Text(
                                                "See all",
                                                style: AppStyle.seeAll,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 17),
                                      SingleChildScrollView(
                                        // controller: scrollController,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 24),
                                            for (int i = 0; i < (state.categoriesExamsResponse?.categoryExams?.length ?? 0); i++)
                                              InkWell(
                                                onTap: () {
                                                  testScreenForCategories(context: context, categoryId: state.categoriesExamsResponse?.categoryExams?[i].category, data: data);
                                                },
                                                child: Container(
                                                  height: 151,
                                                  width: MediaQuery.of(context).size.width * 0.7,
                                                  // padding: const EdgeInsets.only(top: 17, right: 17, left: 14, bottom: 8),
                                                  margin: const EdgeInsets.only(right: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      // color: AppColors.red,
                                                      image: DecorationImage(image: NetworkImage(state.categoriesExamsResponse?.categoryExams?[i].image ?? ""), fit: BoxFit.cover),
                                                      gradient: const LinearGradient(colors: [
                                                        Color.fromRGBO(0, 0, 0, 0.86),
                                                        Color.fromRGBO(34, 43, 69, 0.00),
                                                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                                                  child: Stack(
                                                  alignment: Alignment.bottomCenter,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16),
                                                          gradient: const LinearGradient(colors: [
                                                            Color.fromRGBO(0, 0, 0, 0.86),
                                                            Color.fromRGBO(34, 43, 69, 0.00),
                                                          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 17, right: 17, left: 14, bottom: 8),
                                                      child: Column(
                                                        children: [
                                                          const Spacer(),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                    SizedBox(
                                                                      height: 20,
                                                                      // margin: EdgeInsets.only(right: 100),
                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                      child: Text(
                                                                        state.categoriesExamsResponse?.categoryExams?[i].name ?? "",
                                                                        style: AppStyle.loginButton,
                                                                        maxLines: 1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "20 Frågor",
                                                                      style: AppStyle.cart,
                                                                    ),
                                                                  ],
                                                              ),
                                                              const Spacer(),
                                                              state.categoriesExamsResponse!.categoryExams![i].detail!.isNotEmpty
                                                                  ? InkWell(
                                                                onTap: () {
                                                                  progressVerticalCategories(context: context, detail: state.categoriesExamsResponse!.categoryExams![i].detail);
                                                                        },
                                                                child: Stack(
                                                                  alignment: Alignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "${(state.categoriesExamsResponse?.categoryExams?[i].percent ?? 0).toInt()}%",
                                                                              style: AppStyle.progress1,
                                                                            ),
                                                                    CircularProgressIndicator(
                                                                      value: (state.categoriesExamsResponse?.categoryExams?[i].percent ?? 0) / 100,
                                                                      color: AppColors.green,
                                                                      backgroundColor: AppColors.progressColor,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                                  : InkWell(
                                                                  onTap: () {
                                                                    print('_SuccessScreenState.build 11');
                                                                  },
                                                                  child: SvgPicture.asset("assets/svg/circle_play.svg"))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 27)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24, right: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Träningsprov",
                                          style: AppStyle.sub2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  for (int i = 1; i <= 4; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, right: 24),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (i == 1) {
                                            testScreenForCategories(context: context, categoryId: null, type: 1, data: data, avatarId: (state.profileResponse?.avatarId ?? 0).toInt());
                                          } else if (i == 2) {
                                            testScreenForCategories(context: context, categoryId: null, type: 2, data: data, avatarId: (state.profileResponse?.avatarId ?? 0).toInt(),
                                              allWrongAnswersCount: state.categoriesExamsResponse?.allWrongAnswersCount,wrongAnswersCount:state.categoriesExamsResponse?.wrongAnswersCount ,
                                                savedAnswersCount: state.categoriesExamsResponse?.savedAnswersCount,
                                                allSavedAnswersCount: state.categoriesExamsResponse?.allSavedAnswersCount);
                                          } else if (i == 3) {
                                            testScreenForCategories(context: context, categoryId: null, type: 3, data: data, avatarId: (state.profileResponse?.avatarId ?? 0).toInt(),allWrongAnswersCount: state.categoriesExamsResponse?.allWrongAnswersCount,wrongAnswersCount:state.categoriesExamsResponse?.wrongAnswersCount ,
                                                savedAnswersCount: state.categoriesExamsResponse?.savedAnswersCount,
                                                allSavedAnswersCount: state.categoriesExamsResponse?.allSavedAnswersCount);
                                          } else {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                builder: (context) {
                                                  return Container(
                                                      // margin: const EdgeInsets.only(top: 30),
                                                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                      // height: MediaQuery.of(context).size.height ,
                                                      child: bottomSheetGo(
                                                          onTap: () {
                                                            context.read<CategoriesFilterBloc>().add(CategoriesFinalFilterGetEvent());
                                                            Navigator.pushNamed(context, RouteList.testSuccessScreen, arguments: [false, data, 4]).then((value) {
                                                              Navigator.pop(context);
                                                              CategoriesFilterBloc().close();
                                                            });
                                                          },
                                                          onTapExit: () {
                                                            Navigator.pop(context);
                                                          },
                                                          context: context));
                                                });
                                          }
                                        },
                                        child: Container(
                                          height: 80,
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(bottom: 14),
                                          padding: const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset("assets/svg/more$i.svg"),
                                              const SizedBox(width: 18),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Slumpmässiga",
                                                      style: AppStyle.moreStyle,
                                                    ),
                                                    Text(
                                                      "Välj mellan 10 och 75 slumpmässiga frågor",
                                                      style: AppStyle.subtitle,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.green,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
