import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/screens/main/review_screen/step_custom.dart';
import 'package:korkort/style/app_style.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:share_plus/share_plus.dart';

import '../../../bloc/categories_exams/categories_exams_bloc.dart';
import '../../../style/app_colors.dart';
import '../../../pdf_generate.dart';

class ReviewScreen extends StatefulWidget {
  final Map? data;

  const ReviewScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  double? presentTest = 0;
  int trueAnswers = 0;
  int falseAnswers = 0;
  int questions = 0;
  String? timeTest;
  List data = [];
  List dataCount = [];
  List<int> correctLength = [];
  List<int> wrongLength = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trueAnswers = widget.data?["trueAnswers"];
    questions = widget.data?["questions"];
    timeTest = widget.data?["timeTest"];
    falseAnswers = widget.data?["falseAnswers"];
    presentTest = widget.data?["trueAnswers"] / widget.data?["questions"] * 100;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    value = presentTest! / 100 * .792 - .272;
    _controller.forward();
    (widget.data?["data"] as Map).forEach((key, value) {
      if ((value['wrong'] as List).length + (value['correct'] as List).length != 0) {
        data.add(value);
        correctLength.add((value["correct"] as List).length);
        wrongLength.add((value["wrong"] as List).length);
      }
    });
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load('assets/flutter_logo.png');
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    // scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteAccent,
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              presentTest! <= 50
                  ? Text(
                      "Underkänd 😢",
                      style: AppStyle.appBarTextRed,
                    )
                  : Text(
                      "Godkänd 🤩,",
                      style: AppStyle.appBarTextGreen,
                    ),
              SizedBox(
                  height: 215,
                  width: 215,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/png/spida.png"),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        top: 0,
                        child: RotationTransition(
                          turns: Tween(begin: -0.272, end: value).animate(_controller),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.topLeft,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              "assets/svg/Arrow1.svg",
                              height: 90,
                              width: 90,
                            ),
                          ),
                        ),
                      ),
                      // child: Image.asset("assets/png/arrow.png",height: 90,width: 90,)),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 15,
                          child: Text(
                            "Passing score ${presentTest?.toInt()}%",
                            textAlign: TextAlign.center,
                            style: AppStyle.progressReviewTitle,
                            maxLines: 2,
                          ))
                    ],
                  )),
              // const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (timeTest != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeTest??"",
                          style: AppStyle.ballStyle,
                        ),
                        Text(
                          "Your time",
                          style: AppStyle.ballTitle,
                        )
                      ],
                    ),
                  if (timeTest != null)
                    Container(
                    height: 50,
                    width: 2,
                    margin: const EdgeInsets.only(top: 10, right: 17, left: 17),
                    alignment: Alignment.center,
                    color: AppColors.verticalDivider,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${presentTest!.toInt()}%',
                        style: AppStyle.ballOrangeStyle,
                      ),
                      Text(
                        "Your score",
                        style: AppStyle.ballTitle,
                      )
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    margin: const EdgeInsets.only(top: 10, right: 17, left: 17),
                    alignment: Alignment.center,
                    color: AppColors.verticalDivider,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$trueAnswers/$questions st',
                        style: AppStyle.ballStyle,
                      ),
                      Text(
                        "Right answer",
                        style: AppStyle.ballTitle,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            margin:const EdgeInsets.only(left: 25,right: 25,top: 20),
            padding:const EdgeInsets.only(top: 24,left: 22,right: 22,bottom: 31),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white
            ),
            constraints:  BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height-500),
            // color: AppColors.red,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  for(int i=0;i<data.length;i++)
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      // color: AppColors.red,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  data[i]["name"],
                                  style: AppStyle.progressReviewTitleCategory,
                                  maxLines: 1,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                style: AppStyle.progressReviewTitle1,
                                maxLines: 1,
                                "${(data[i]["correct"] as List).length}/${(data[i]["correct"] as List).length + (data[i]["wrong"] as List).length}",
                              )
                            ],
                          ),
                          const SizedBox(height: 2),
                          StepProgressIndicatorCustom(
                            totalSteps: 10,
                            currentStep: ((correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10 > 0 &&
                                    (correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10 < 1)
                                ? 1
                                : ((correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10).toInt(),
                            selectedColor: AppColors.greenAccent,
                            unselectedColor: AppColors.progressReviewGrey1,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
         // const Spacer(),
        ],
      ),
    ),
            bottomNavigationBar:           Container(
              padding:const EdgeInsets.only(bottom: 20),
              color: AppColors.whiteAccent,
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  Expanded(
                      child: buttonLogin(
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<CategoriesExamsBloc>().add(CategoriesExamsGetEvent());
                          },
                          label: "Go to exam",
                          isActive: true)),
                  const SizedBox(width: 16),
                  GestureDetector(
                      onTap: () async {
                        shareFile(data: widget.data);
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.greenAccent,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/share1.svg",
                              color: AppColors.white,
                            ),
                          ))),
                  const SizedBox(width: 24),
                ],
              ),
            ),

    );
  }
}
