import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' show get;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';
import 'package:korkort/screens/main/home/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:path_provider/path_provider.dart';


import '../../../bloc/lesson/lesson_bloc.dart';
import '../../../bloc/lessons_question/lessons_question_bloc.dart';
import '../../../route/route_constants.dart';
import '../../../style/app_style.dart';
import '../profile_screen/profile_item.dart';
import '../review_screen/review_item.dart';
import '../success/test/custom.dart';

class TestScreen extends StatefulWidget {
  // final LessonResponse? lessonResponse;
  final List? testData;

  const TestScreen({Key? key, this.testData}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  double progress = 0;
  double? progressItem;
  int? index = -1;
  bool? isChecking;
  bool isCorrect = true;
  int questionId = 0;
  int questionLength = 0;
  List answerFalse = [];
  final _gifController = GifController(autoPlay: false, loop: false);
  late FlutterGifController controller1;
  bool isSaved = false;
  bool isPlay = false;
ScrollController scrollController=ScrollController();
  List<NetworkImage> networkGif = [];
  List<String> gifViewMap = [];
  bool isNext = false;

  _downloadAndSavePhoto(String urlImage, String title) async {
    var url = urlImage;
    var response = await get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/$title/images";
    await Directory(firstPath).create(recursive: true);
    var filePathAndName = '${documentDirectory.path}/$title/images/pic.gif';
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    gifViewMap.add(filePathAndName);
    isNext = false;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    context.read<LessonsQuestionBloc>().add(LessonsQuestionIdEvent(id: widget.testData?[0]));
    controller1 = FlutterGifController(vsync: this);
    _gifController.addListener(() {
      if (_gifController.status == GifStatus.stoped) {
        isNext = false;
        setState(() {});
      }
    });
    // lessonResponse = widget.testData?[0];

    // if(state.questionResponseList?[questionId].isSaved!=null){
    //   isSaved=state.questionResponseList?[questionId].isSaved!;
    // }
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
  void scrollFirst() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    print(gifViewMap);
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      body: BlocConsumer<LessonsQuestionBloc, LessonsQuestionState>(
        listener: (context, state) {
          if (state is LessonsQuestionLoaded) {
            if (state.questionResponseList?[questionId].isSaved != null) {
              isSaved = state.questionResponseList![questionId].isSaved!;
            }
            questionLength = state.questionResponseList?.length ?? 1;
            // progress= 1 / (state.questionResponseList?.length ?? 1);
            progressItem = 1 / (state.questionResponseList?.length ?? 1);
            for (int i = 0; i < questionLength; i++) {
                _downloadAndSavePhoto(state.questionResponseList?[i].questionGif ?? "", i.toString());
            }

          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LessonsQuestionLoaded) {
            return Column(
              children: [
                const SizedBox(
                  height: 44,
                ),
                Row(
                  children: [
                    const SizedBox(width: 26),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                            builder: (context) {
                              return bottomSheetCustom(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    controller1.dispose();

                                  },
                                  icon: "exit_test",
                                  title: "Felaktigt besvarade frågor",
                                  desc: "Your account password has been updated, you can already login with your new password.");
                            });
                      },
                      child: SvgPicture.asset("assets/svg/close1.svg",color: AppColors.green,),
                    ),
                    const Spacer(),
                    Text(
                      "Träningsprov",
                      style: AppStyle.appBarStyle,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                      child: isSaved ? SvgPicture.asset("assets/svg/save_done.svg") : SvgPicture.asset("assets/svg/save.svg"),
                    ),
                    const SizedBox(width: 26),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          animation: false,
                          lineHeight: 6.0,
                          percent: progress>1?1:progress,
                          backgroundColor: const Color(0xffD6D6D6),
                          barRadius: const Radius.circular(20),
                          progressColor: AppColors.greenAccent,
                        ),
                      ),
                    ),
                    Text("$questionId/$questionLength", style: AppStyle.testProgress),
                    const SizedBox(
                      width: 25,
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 33.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.questionResponseList?[questionId].questionGif != null)
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: gifViewMap.isNotEmpty
                                            ? gifViewMap[questionId].isNotEmpty
                                            ? GifViewCustom.memory(
                                          File(gifViewMap[questionId]).readAsBytesSync(),
                                          controller: _gifController,
                                          progress: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.green,
                                            ),
                                          ),
                                          isNext: isNext,
                                        )
                                            : const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.green,
                                          ),
                                        )
                                            : const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 9,
                                          right: 11,
                                          child: InkWell(
                                              onTap: () {
                                                if (_gifController.status == GifStatus.playing) {
                                                  _gifController.pause();
                                                } else if (_gifController.status == GifStatus.paused || _gifController.status == GifStatus.stoped) {
                                                  _gifController.play();
                                                }
                                                isNext = false;
                                                setState(() {});
                                              },
                                              child: SvgPicture.asset("assets/svg/${_gifController.status == GifStatus.playing ? "pause" : "play__on"}"
                                                  ".svg"))),
                                    ],                                  ),
                                ),
                              if (state.questionResponseList?[questionId].questionGif == null && state.questionResponseList?[questionId].questionImage != null)
                                Image.network(
                                  state.questionResponseList?[questionId].questionImage ?? "",
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              if (state.questionResponseList?[questionId].questionGif != null || state.questionResponseList?[questionId].questionImage != null) const SizedBox(height: 10),
                              Text(
                                state.questionResponseList?[questionId].questionText ?? "",
                                style: AppStyle.testStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SingleChildScrollView(
                          controller: scrollController,
                          physics:const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              for (int i = 0; i < (state.questionResponseList?[questionId].variantSet?.length ?? 0); i++)
                                testItem(
                                    onTap: () {
                                      setState(() {
                                        isNext = false;
                                        if ((isChecking ?? true) && isCorrect) {
                                          index = i;
                                          isCorrect = false;
                                        }
                                        if ((index ?? -1) >= 0) {
                                          isChecking = state.questionResponseList?[questionId].variantSet?[index!].isCorrect;
                                          if (((!isChecking!))) {
                                            answerFalse.add({
                                              "pk": state.questionResponseList?[questionId].id,
                                            });
                                          }
                                        }
                                      });
                                    },
                                    index: index,
                                    item: i,
                                    title: state.questionResponseList?[questionId].variantSet?[i].text ?? "",
                                    isTrue: isChecking),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                                child: buttonLogin(
                                    onPressed: () {
                                      if (state.questionResponseList?[questionId].isSaved != null) {
                                        if (state.questionResponseList?[questionId].isSaved != isSaved) {
                                          context.read<LessonBloc>().add(LessonTestEvent(testId: state.questionResponseList?[questionId].id));
                                        }
                                      }
                                      if ((index ?? -1) >= 0) {
                                        if (questionId + 1 < questionLength) {
                                          questionId++;
                                          _gifController.play();
                                          isNext = true;
                                          scrollFirst();
                                          isPlay=true;
                                          isSaved = state.questionResponseList?[questionId].isSaved ?? false;
                                          index = -1;
                                          isChecking = null;
                                        } else {
                                          showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                              builder: (context) {
                                                return Container(
                                                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                    height: MediaQuery.of(context).size.height * 0.8,
                                                    child: bottomSheetSuccess(
                                                        trueAnswer: (questionLength - (answerFalse.length)),
                                                        falseAnswer: answerFalse.length,
                                                        onTap: () async{
                                                          Navigator.pop(context);
                                                          context.read<LessonBloc>().add(LessonAnswerTrueEvent(answerTrue: answerFalse, id: widget.testData?[0], chapterId: widget.testData![1]));
                                                          if (questionLength - (answerFalse.length) == questionLength && widget.testData?[2] == true) {
                                                            showModalBottomSheet(
                                                                context: context,
                                                                isScrollControlled: true,
                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                                builder: (context) {
                                                                  return Container(
                                                                      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                                      height: MediaQuery.of(context).size.height * 0.7,
                                                                      child: bottomSheetGoTariff(
                                                                          onTap: () async{
                                                                            Navigator.pushNamed(context, RouteList.tariffScreen);
                                                                            for (int i = 0; i < gifViewMap.length; i++) {
                                                                              await Directory(gifViewMap[i]).delete(recursive: true);
                                                                            }
                                                                          },
                                                                          onTapExit: ()async {
                                                                            Navigator.pop(context);
                                                                            for (int i = 0; i < gifViewMap.length; i++) {
                                                                              await Directory(gifViewMap[i]).delete(recursive: true);
                                                                            }
                                                                          },
                                                                          context: context));
                                                                });
                                                          } else {
                                                            Navigator.pop(context);
                                                            for (int i = 0; i < gifViewMap.length; i++) {
                                                              await Directory(gifViewMap[i]).delete(recursive: true);
                                                            }
                                                          }
                                                        },
                                                        onTapExit: () async{
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                          for (int i = 0; i < gifViewMap.length; i++) {
                                                            await Directory(gifViewMap[i]).delete(recursive: true);
                                                          }
                                                        }));
                                              });
                                        }

                                        setState(() {
                                          isCorrect = true;
                                          progress += progressItem ?? 0;
                                        });
                                      }
                                    },
                                    label: "Nästa fråga",
                                    isActive: (index ?? -1) >= 0),
                              ),
                              const SizedBox(height: 70),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.greenAccent,
            ),
          );
        },
      ),
    );
  }
}

