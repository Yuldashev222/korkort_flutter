import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/bloc/categories_filter/categories_filter_bloc.dart';
import 'package:korkort/bloc/profile/profile_bloc.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../model/categories_exams_response.dart';

Future progressVerticalCategories({BuildContext? context, List<Detail>? detail,}) {
  return showModalBottomSheet(
    backgroundColor: AppColors.white,
      context: context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             const SizedBox(height: 43),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text("Your last 10 test results"),
              ),
              Container(
                padding: const EdgeInsets.only(left: 25, top: 25),
                decoration: const BoxDecoration(color: AppColors.white),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        for (int i = 5; i >= 0; i--)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 25,
                                      child: Text(
                                        "${i * 20}%",
                                        style: AppStyle.stat,
                                      )),
                                  const SizedBox(width: 5),
                                  const Flexible(
                                    child: Divider(
                                      color: AppColors.buttonShadow,
                                      height: 1,
                                      thickness: 1,

                                    ),
                                  ),
                                  const SizedBox(width: 25),

                                ],
                              ),
                              const SizedBox(height: 17)
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 44,right: 25),
                        height: 185,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (int i = 0; i < (detail?.length??0); i++)
                              Column(
                                children: [
                                 const SizedBox(height: 2),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: i == (detail?.length??0)-1 ? 0 : 20.0, top: 0, bottom: 0),
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 7.0,
                                          animationDuration: 500,
                                          percent: (detail?[i].percent)! / 100 == 0
                                              ? (detail?[i].questions != 0)
                                                  ? 0.03
                                                  : 0
                                              : (detail?[i].percent)! / 100,
                                          backgroundColor: AppColors.verticalDivider,
                                          barRadius: const Radius.circular(20),
                                          progressColor: AppColors.sliderGreen,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(right: i == (detail?.length??0)-1 ? 0 : 20.0),
                                      child: Text(
                                        "${detail?[i].questions}",
                                        style: AppStyle.statSubtitle,
                                      ))
                                ],
                              ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 34,
                      child: DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 4.0,
                        dashColor: AppColors.onProgress,
                      ),
                    ),
                    const  SizedBox(width: 6),
                    Text("Number of questions",style: AppStyle.progressReviewTitle1,),
                    const SizedBox(width: 6),
                    const  Flexible(
                      child: DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 4.0,
                        dashColor: AppColors.onProgress,
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24),
                child: buttonLogin(onPressed: (){
                  Navigator.pop(context);
                }, label: "Close", isActive: false),
              ),
              const SizedBox(height: 30,)
            ],
          ),
        );
      });
}

Future testScreenForCategories(
    {BuildContext? context, int? categoryId, int? type, Map? data, int? avatarId, int? allWrongAnswersCount, int? wrongAnswersCount, int? savedAnswersCount, int? allSavedAnswersCount}) {
  return showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 100, // here increase or decrease in width
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      builder: (context) {
        return TestScreenFilter(
          categoryId: categoryId,
          type: type,
          data: data,
          avatarId: avatarId,
          allSavedAnswersCount: allSavedAnswersCount,
          allWrongAnswersCount: allWrongAnswersCount,
          wrongAnswersCount: wrongAnswersCount,
          savedAnswersCount: savedAnswersCount,
        );
      });
}

class TestScreenFilter extends StatefulWidget {
  final int? categoryId;
  final int? avatarId;
  final int? type;
  final Map? data;
  final int? allWrongAnswersCount;
  final int? wrongAnswersCount;
  final int? savedAnswersCount;
  final int? allSavedAnswersCount;

  TestScreenFilter({Key? key, this.categoryId, this.type, this.data, this.avatarId, this.allSavedAnswersCount, this.savedAnswersCount, this.wrongAnswersCount, this.allWrongAnswersCount})
      : super(key: key);

  @override
  State<TestScreenFilter> createState() => _TestScreenFilterState();
}

class _TestScreenFilterState extends State<TestScreenFilter> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double currentSliderValue = 5;
  double currentSliderValueQuiz = 5;
  int currentInt = 5;
  bool switchCupertino = false;
  bool switchChoose = false;
  double heightT = 0.5;
  int? level;
  bool isAll = true;
  List categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('_TestScreenFilterState.build ${widget.data}');
    return BlocConsumer<CategoriesFilterBloc, CategoriesFilterState>(
      listener: (context, state) {
        // if(state is CategoriesFilterLoaded){
        //   Navigator.pushNamed(context, RouteList.testSuccessScreen, arguments: switchChoose).then((value) {
        //     Navigator.pop(context);
        //   });
        // } else if(state is CategoriesMixFilterLoaded){
        //   Navigator.pushNamed(context, RouteList.testSuccessScreen, arguments: switchChoose).then((value) {
        //     Navigator.pop(context);
        //   });
        // }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 27.0, right: 27),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text("Select number of questions", style: AppStyle.sendCode),
                const SizedBox(height: 28),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 8.0,
                    trackShape: const RoundedRectSliderTrackShape(),
                    activeTrackColor: AppColors.sliderGreen,
                    inactiveTrackColor: AppColors.sliderGrey,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 10.0,
                      // pressedElevation: 8.0,
                    ),
                    thumbColor: AppColors.sliderGreen,
                    overlayColor: Colors.transparent,
                    // overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
                    tickMarkShape: const RoundSliderTickMarkShape(),
                    activeTickMarkColor: Colors.transparent,
                    inactiveTickMarkColor: Colors.transparent,
                    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: AppColors.sliderGreen,
                    valueIndicatorTextStyle: AppStyle.slideItem,
                  ),
                  child: Slider(
                    min: 5.0,
                    max:widget.categoryId != null?20.0: 65.0,
                    value: currentSliderValue,
                    divisions: 13,
                    label: '${currentSliderValue.round()}',
                    onChanged: (value) {
                      setState(() {
                        currentSliderValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Choose quize mode", style: AppStyle.sendCode),
                    CupertinoSwitch(
                        value: switchCupertino,
                        onChanged: (value) {
                          setState(() {
                            switchCupertino = value;
                            if (switchCupertino) {
                              heightT = 0.6;
                              level = 1;
                            } else {
                              heightT = 0.5;
                              level = null;
                            }
                          });
                        }),
                  ],
                ),
                if (switchCupertino) const SizedBox(height: 30),
                if (switchCupertino)
                  Container(
                    height: 8,
                    // margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFF7ED222),
                        Color(0xFFEDFF1C),
                        Color(0xFFEE3A01),
                      ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, __) {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.transparent,
                            inactiveTrackColor: Colors.transparent,
                            showValueIndicator: ShowValueIndicator.always,
                            trackHeight: 0.1,
                            thumbColor: const Color(0xFF7ED321),
                            overlayColor: Colors.white.withAlpha(1),
                            trackShape: const RoundedRectSliderTrackShape(),
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10.0,
                              // pressedElevation: 8.0,
                            ),
                            tickMarkShape: const RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: AppColors.sliderGreen,
                            valueIndicatorTextStyle: AppStyle.slideItem,
                          ),
                          child: Slider(
                            divisions: 2,
                            label: _animationController.value == 0.0
                                ? "Easy"
                                : _animationController.value == 0.5
                                    ? "Middle"
                                    : "Strong",
                            value: _animationController.value,
                            onChanged: (e) {
                              _animationController.value = e;
                              if (_animationController.value == 0.0) {
                                level = 1;
                              } else if (_animationController.value == 0.5) {
                                level = 2;
                              } else if (_animationController.value == 1) {
                                level = 3;
                              }
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                  ),
                if (widget.type == 1) const SizedBox(height: 30),
                if (widget.type == 1) Text("Categories", style: AppStyle.sendCode),
                if (widget.type == 1) const SizedBox(height: 11),
                if (widget.type == 1)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 10,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        children: [
                          for (int i = 0; i < (widget.data?.length ?? 0); i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 9.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (categoryList.contains(i + 1)) {
                                      categoryList.remove(i + 1);
                                    } else {
                                      categoryList.add(i + 1);
                                    }
                                  });
                                },
                                child: Container(
                                  //height: 35,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: categoryList.contains(i + 1) ? AppColors.green : AppColors.white,
                                      border: Border.all(color: categoryList.contains(i + 1) ? Colors.transparent : AppColors.grey3)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
                                      child: Text(
                                        (widget.data?.values)?.toList()[i]["name"],
                                        style: categoryList.contains(i + 1) ? AppStyle.category : AppStyle.categoryGrey,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/choose_time.svg"),
                    const SizedBox(width: 16),
                    Text("Choose quize mode", style: AppStyle.sendCode),
                    const Spacer(),
                    CupertinoSwitch(
                        value: switchChoose,
                        onChanged: (value) {
                          setState(() {
                            switchChoose = value;
                          });
                        }),
                  ],
                ),
                if (widget.type == 2 || widget.type == 3) const SizedBox(height: 27),
                if (widget.type == 2 || widget.type == 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if((widget.type == 2&&widget.wrongAnswersCount==0)||(widget.type == 3&&widget.savedAnswersCount==0)){}
                              else{
                                setState(() {
                                  isAll = false;
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: 153,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.greenAccent, width: 2),
                                    color: AppColors.whiteAccent1,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 11,
                                          left: 10,
                                          child: SvgPicture.asset(
                                            "assets/svg/${!isAll ? "success" : "ellipse"}.svg",
                                            height: 24,
                                            width: 24,
                                          )),
                                      Positioned(
                                          top: 24,
                                          right: 32,
                                          left: 32,
                                          bottom: 24,
                                          child: Stack(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/avatar_background.svg",
                                                height: 93,
                                                width: 88,
                                              ),
                                              Positioned(
                                                left: 2,
                                                right: 2,
                                                top: 2,
                                                bottom: 2,
                                                child: SvgPicture.asset(
                                                  "assets/svg_avatar/avatar${widget.avatarId ?? 0}.svg",
                                                  height: 93,
                                                  width: 88,
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                if((widget.type == 2&&widget.wrongAnswersCount==0)||(widget.type == 3&&widget.savedAnswersCount==0))
                                Container(
                                  height: 140,
                                  width: 153,
                                  color: AppColors.white.withOpacity(0.6),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "My wrong answers",
                            style: AppStyle.oneType,
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if((widget.type == 2&&widget.allWrongAnswersCount==0)||(widget.type == 3&&widget.allSavedAnswersCount==0)){
                              }else{
                                setState(() {
                                  isAll = true;
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: 153,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.greenAccent, width: 2),
                                    color: AppColors.whiteAccent1,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 11,
                                          left: 10,
                                          child: SvgPicture.asset(
                                            "assets/svg/${isAll ? "success" : "ellipse"}.svg",
                                            height: 24,
                                            width: 24,
                                          )),
                                      Positioned(
                                          top: 24,
                                          right: 32,
                                          left: 32,
                                          bottom: 24,
                                          child: SvgPicture.asset(
                                            "assets/svg/group_avatars.svg",
                                            height: 93,
                                            width: 88,
                                          ))
                                    ],
                                  ),
                                ),
                                if((widget.type == 2&&widget.allWrongAnswersCount==0)||(widget.type == 3&&widget.allSavedAnswersCount==0))
                                  Container(
                                  height: 140,
                                  width: 153,
                                  color: AppColors.white.withOpacity(0.6),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Others wrong answers",
                            style: AppStyle.oneType,
                          )
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 27),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: const [BoxShadow(offset: Offset(0, 26), blurRadius: 60, spreadRadius: 0, color: AppColors.shadowButton)]),
                  child: buttonLogin(
                      onPressed: () {
                        if (widget.categoryId != null) {
                          context.read<CategoriesFilterBloc>().add(CategoriesFilterGetEvent(difficultyLevel: level, questions: currentSliderValue.round(), categoryId: widget.categoryId));
                        } else if (widget.type == 1) {
                          context.read<CategoriesFilterBloc>().add(CategoriesMixFilterGetEvent(difficultyLevel: level, questions: currentSliderValue.round(), categoryIds: categoryList));
                        } else if (widget.type == 2) {
                          context.read<CategoriesFilterBloc>().add(CategoriesWrongFilterGetEvent(difficultyLevel: level, questions: currentSliderValue.round(), myQuestions: !isAll));
                        } else if (widget.type == 3) {
                          context.read<CategoriesFilterBloc>().add(CategoriesSavedFilterGetEvent(difficultyLevel: level, questions: currentSliderValue.round(), myQuestions: !isAll));
                        }
                        Navigator.pushNamed(context, RouteList.testSuccessScreen, arguments: [switchChoose, widget.data, widget.type]).then((value) {
                          Navigator.pop(context);
                          context.read<ProfileBloc>().add(ProfileGetEvent());
                          CategoriesFilterBloc().close();
                        });
                      },
                      label: "Update Settings",
                      isActive: true),
                ),
                const SizedBox(height: 5),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
        );
      },
    );
  }
}
