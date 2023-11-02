import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/main/home/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../bloc/lesson/lesson_bloc.dart';
import '../../../bloc/lessons_chapter/lessons_chapter_bloc.dart';
import '../../../style/app_style.dart';
import '../../tariff/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double progress = 0;
  int countIsOpen = 0;

  @override
  void initState() {
    super.initState();
    context.read<LessonsChapterBloc>().add(LessonsChapterIdEvent(lessonsChapterId: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LessonsChapterBloc, LessonsChapterState>(
        listener: (context, state) {
          if (state is LessonsChapterLoaded) {
            progress = (state.profileResponse?.levelPercent ?? 0) / 100;
            countIsOpen = 4;
            setState(() {});
            for (int i = 0; i < (state.lessonChapterResponseList?.length ?? 0); i++) {
              if (state.lessonChapterResponseList?[i].isOpen != 3 && state.lessonChapterResponseList?[i].isOpen != 4) {
                setState(() {
                  // countIsOpen++;
                });
              }
            }
          }
        },
        builder: (context, state) {
          if (state is LessonsChapterLoaded) {
            return Container(
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
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 58),
                                  Container(
                                    margin: const EdgeInsets.only(left: 24, right: 24),
                                    padding: const EdgeInsets.only(left: 9, right: 9, top: 1, bottom: 1),
                                    width: double.infinity,
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
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
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
                                                )),
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
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Kapitel",
                                                          style: AppStyle.mainStyle,
                                                        ),
                                                        Text(
                                                          "${state.profileResponse?.completedLessons ?? 0}/${state.profileResponse?.allLessonsCount ?? 0}",
                                                          style: AppStyle.mainStyleProgress,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 18),
                                            Row(
                                              children: [
                                                Text(
                                                  "Steg-för-steg lektioner",
                                                  style: AppStyle.sub1,
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${state.isOpenCount==0?"": "${state.isOpenCount}/"}${state.lessonChapterResponseList?.length ?? 0}",
                                                  style: AppStyle.mainNumber,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      for (int i = 0; i < (state.lessonChapterResponseList?.length ?? 0); i++)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.mainWhite, boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 4),
                                                    blurRadius: 30,
                                                    color: AppColors.shadowLesson,
                                                    spreadRadius: 0,
                                                  )
                                                ]),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 140,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                  state.lessonChapterResponseList?[i].image ?? "",
                                                                ),
                                                                fit: BoxFit.cover,
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                          child: LinearPercentIndicator(
                                                            padding:const EdgeInsets.all(0),
                                                            animation: true,
                                                            lineHeight: 7.0,
                                                            animationDuration: 2000,
                                                            percent:  ((state.lessonChapterResponseList?[i].completedLessons ?? 1) / (state.lessonChapterResponseList?[i].lessons ?? 1))==0?0.02:(
                                                                (state.lessonChapterResponseList?[i].completedLessons ?? 1) / (state.lessonChapterResponseList?[i].lessons ?? 1)) ,
                                                            backgroundColor: AppColors.sliderDivider1,
                                                            barRadius: const Radius.circular(10),
                                                            progressColor: AppColors.greenAccent,
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   // margin: EdgeInsets.symmetric(vertical: 20),
                                                        //   height: 6,
                                                        //   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                                                        //   child: ClipRRect(
                                                        //     borderRadius: const BorderRadius.only(bottomRight: Radius.circular(2), bottomLeft: Radius.circular(2)),
                                                        //     child: LinearProgressIndicator(
                                                        //       valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF94D073)),
                                                        //       value: ((state.lessonChapterResponseList?[i].completedLessons ?? 1) / (state.lessonChapterResponseList?[i].lessons ?? 1)),
                                                        //       backgroundColor: const Color(0xffD6D6D6),
                                                        //     ),
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ExpandableText(
                                                      state.lessonChapterResponseList?[i].title ?? '',
                                                      trimType: TrimType.characters,
                                                      trim: 100, // trims if text exceeds 20 characters
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/svg/lessons.svg",
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          "${state.lessonChapterResponseList?[i].lessons ?? 0} lessons",
                                                          style: AppStyle.lessonsTeg,
                                                        ),
                                                        const SizedBox(width: 26),
                                                        SvgPicture.asset(
                                                          "assets/svg/time.svg",
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          "${state.lessonChapterResponseList?[i].chapterHour ?? 0} hrs ${state.lessonChapterResponseList?[i].chapterMinute ?? 0} mins",
                                                          style: AppStyle.lessonsTeg,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Divider(),
                                                    const SizedBox(height: 7),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: const [BoxShadow(offset: Offset(0, 26), blurRadius: 60, spreadRadius: 0, color: AppColors.shadowButton)]),
                                                      child: buttonLogin1(
                                                          onPressed: () {
                                                            if ((state.lessonChapterResponseList?[i].isOpen != 4 && state.lessonChapterResponseList?[i].isOpen != 3)) {
                                                              context.read<LessonBloc>().add(LessonIdForChaptersEvent(id: state.lessonChapterResponseList?[i].id));
                                                              Navigator.pushNamed(context, RouteList.lessonScreen, arguments: state.lessonChapterResponseList?[i].id);
                                                            } else if (state.lessonChapterResponseList?[i].isOpen == 4) {
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
                                                            }
                                                          },
                                                          label: "Starta kapitel",
                                                          isActive: (state.lessonChapterResponseList?[i].isOpen != 4 && state.lessonChapterResponseList?[i].isOpen != 3),
                                                          isLock: state.lessonChapterResponseList?[i].isOpen == 4 ? "carona" : "lock"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (i < (state.lessonChapterResponseList?.length ?? 0) - 1)
                                                const SizedBox(
                                                  height: 36,
                                                  child: DottedLine(
                                                    direction: Axis.vertical,
                                                    alignment: WrapAlignment.center,
                                                    lineLength: double.infinity,
                                                    lineThickness: 2.0,
                                                    dashLength: 4.0,
                                                    dashColor: AppColors.greenAccent,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 30)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          else {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.whiteAccent
              ),
              child: Stack(
                children: [
                  Positioned(
                      child: CustomPaint(
                        painter:  MyPainter(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 110, sigmaX: 110),
                          child: Container(
                            height: 300.0,
                          ),
                        ),
                      )),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

