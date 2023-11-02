import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show get;
import 'package:korkort/model/exam_question_response.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/screens/main/home/widget.dart';
import 'package:korkort/screens/main/success/test/custom.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../bloc/categories_filter/categories_filter_bloc.dart';
import '../../../../bloc/lesson/lesson_bloc.dart';
import '../../../../style/app_style.dart';
import '../../profile_screen/profile_item.dart';

class TestSuccessScreen extends StatefulWidget {
  final List? timerAndData;

  const TestSuccessScreen({Key? key, this.timerAndData}) : super(key: key);

  @override
  State<TestSuccessScreen> createState() => _TestSuccessScreenState();
}

class _TestSuccessScreenState extends State<TestSuccessScreen> with TickerProviderStateMixin {
  double progress = 0;
  double? progressItem;
  int? index = -1;
  bool? isChecking;
  bool isCorrect = true;
  int questionId = 0;
  int questionLength = 0;
  Set answerFalse = {};
  Set answerTrue = {};
  final _gifController = GifController(autoPlay: false, loop: false);
  bool isSaved = false;
  bool isPlay = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration();
  Duration myDurationTest = const Duration();
  int saveCount = 0;
  int count = 0;
  bool isError = true;
  Map data = {};
  bool isFirstError = true;
  GetStorage getStorage = GetStorage();
  ScrollController scrollController = ScrollController();
  // List<String> gifViewMap = [];
  List<Uint8List> gifViewMapUnit = [];
  bool isNext = false;

  _downloadAndSavePhoto(String urlImage, String title) async {
    var url = urlImage;
    var response = await get(Uri.parse(url));
    // var documentDirectory = await getApplicationDocumentsDirectory();
    // var firstPath = "${documentDirectory.path}/images";
    // await Directory(firstPath).create(recursive: true);
    // var filePathAndName = '${documentDirectory.path}/images/$title.gif';
    // File file2 = File(filePathAndName);
    // file2.writeAsBytesSync(response.bodyBytes);
    gifViewMapUnit.add(response.bodyBytes);
    // gifViewMap.add(filePathAndName);
    isNext = false;

    // print('_TestSuccessScreenState._downloadAndSavePhoto ${gifViewMap.length}');

    if (gifViewMapUnit.length < 2) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    data = widget.timerAndData?[1];
    _gifController.addListener(() {
      if (_gifController.status == GifStatus.stoped) {
        isNext = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _gifController.dispose();

    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    isNext = false;
    setState(() {});
    const reduceSecondsBy = 1;
    var seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      seconds = 0;
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
  }

  void scroll() {
    if(widget.timerAndData?[2]!=4){
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
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
  String timeTest(){
    String strDigits(int n) => n.toString().padLeft(2, '0');

  Duration timeTest=(myDurationTest-myDuration);
    final minutes = strDigits(timeTest.inMinutes.remainder(60));
    final hours = strDigits(timeTest.inHours.remainder(60));
    final seconds = strDigits(timeTest.inSeconds.remainder(60));
    return "${hours != "00" ? "$hours." : ""}$minutes.$seconds";
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final hours = strDigits(myDuration.inHours.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     timeTest();
      //     },
      // ),
      backgroundColor: AppColors.whiteAccent,
      body: BlocConsumer<CategoriesFilterBloc, CategoriesFilterState>(
        listener: (context, state) {
          if (state is CategoriesFilterLoaded) {
            List<Questions> questions = state.examsQuestionResponse!.questions ?? [];
            if (questions.isNotEmpty) {
              if (questions[questionId].isSaved != null) {
                isSaved = questions[questionId].isSaved!;
              }
              questionLength = questions.length;
              progressItem = 1 / (questions.length);
              for (int i = 0; i < questionLength; i++) {
                _downloadAndSavePhoto(state.examsQuestionResponse?.questions?[i].questionGif ?? "", i.toString());
              }
              if (widget.timerAndData?[0] ?? false) {
                myDuration = Duration(minutes: questionLength);
                myDurationTest = Duration(minutes: questionLength);
                startTimer();
              }
              isNext = false;
              setState(() {});
            }
          } else if (state is CategoriesMixFilterLoaded) {
            if (state.mixQuestionsResponseList!.isNotEmpty) {
              if (state.mixQuestionsResponseList?[questionId].isSaved != null) {
                isSaved = state.mixQuestionsResponseList![questionId].isSaved!;
              }
              questionLength = state.mixQuestionsResponseList?.length ?? 1;
              progressItem = 1 / (state.mixQuestionsResponseList?.length ?? 1);

              for (int i = 0; i < questionLength; i++) {
                _downloadAndSavePhoto(state.mixQuestionsResponseList?[i].questionGif ?? "", i.toString());
              }
              if (widget.timerAndData?[0] ?? false) {
                myDuration = Duration(minutes: questionLength);
                myDurationTest = Duration(minutes: questionLength);
                startTimer();
              }
              isNext = false;
              setState(() {});
            }
          }
        },
        builder: (context, state) {
          if (state is CategoriesFilterLoaded) {
            if (state.examsQuestionResponse!.questions!.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 26),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                              builder: (context) {
                                return bottomSheetCustom(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    icon: "exit_test",
                                    title: "Felaktigt besvarade frågor",
                                    desc: "Your account password has been updated, you can already login with your new password.");
                              });
                        },
                        child: SvgPicture.asset(
                          "assets/svg/back.svg",
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const Spacer(),
                      if (widget.timerAndData?[0] ?? false)
                        Container(
                          padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.testSuccess),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svg/clock.svg"),
                              const SizedBox(width: 4),
                              Text("${hours != "00" ? "$hours:" : ""}$minutes:$seconds"),
                            ],
                          ),
                        ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          saveCount++;
                          if (saveCount == 1) {
                            if (getStorage.read("is_saved") == null) {
                              getStorage.write("is_saved", true);
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                  builder: (context) {
                                    return bottomSheetCustom(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: "save_test",
                                        title: "Felaktigt besvarade frågor",
                                        desc: "Your account password has been updated, you can already login with your new password.");
                                  });
                            }
                          }
                          isNext = false;
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                        child: isSaved
                            ? SvgPicture.asset(
                                "assets/svg/save_done.svg",
                                height: 35,
                                width: 35,
                              )
                            : SvgPicture.asset(
                                "assets/svg/save.svg",
                                height: 35,
                                width: 35,
                              ),
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
                            percent: progress > 1 ? 1 : progress,
                            backgroundColor: const Color(0xffD6D6D6),
                            barRadius: const Radius.circular(20),
                            progressColor: AppColors.greenAccent,
                          ),
                        ),
                      ),
                      Text("$count/${(state.examsQuestionResponse?.questions?.length ?? 1)}", style: AppStyle.testProgress),
                      const SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(top: 33.0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics:const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (state.examsQuestionResponse?.questions?[questionId].questionGif != null)
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
                                              child: gifViewMapUnit.isNotEmpty
                                                  ? gifViewMapUnit.length>=questionId+1
                                                      ? GifViewCustom.memory(
                                                gifViewMapUnit[questionId],
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
                                          ],
                                        ),
                                      ),
                                    if (state.examsQuestionResponse?.questions?[questionId].questionGif == null && state.examsQuestionResponse?.questions?[questionId].questionImage != null)
                                      Image.network(
                                        state.examsQuestionResponse?.questions?[questionId].questionImage ?? "",
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    if (state.examsQuestionResponse?.questions?[questionId].questionGif != null || state.examsQuestionResponse?.questions?[questionId].questionImage != null)
                                      const SizedBox(height: 10),
                                    Text(
                                      state.examsQuestionResponse?.questions?[questionId].questionText ?? "",
                                      style: AppStyle.testStyle,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < (state.examsQuestionResponse?.questions?[questionId].variantSet?.length ?? 0); i++)
                                    testItem(
                                        onTap: () async {
                                          setState(() {
                                            isNext = false;
                                            if ((isChecking ?? true) && isCorrect) {
                                              index = i;
                                              isCorrect = false;
                                            }
                                            if ((index ?? -1) >= 0) {
                                              isChecking = state.examsQuestionResponse?.questions?[questionId].variantSet?[index!].isCorrect;
                                              if (!isChecking!) {
                                                isError = true;
                                                if (isFirstError) {
                                                  scroll();
                                                  isFirstError = false;
                                                }

                                                (data[state.examsQuestionResponse?.questions?[i].categoryId.toString()]["wrong"] as List).clear();
                                                answerFalse.add(state.examsQuestionResponse?.questions?[questionId].id);
                                                for (int i = 0; i < answerFalse.length; i++) {
                                                  (data[state.examsQuestionResponse?.questions?[i].categoryId.toString()]["wrong"] as List).add({"pk": answerFalse.toList()[i]});
                                                }
                                              } else {
                                                isError = false;
                                                (data[state.examsQuestionResponse?.questions?[i].categoryId.toString()]["correct"] as List).clear();
                                                answerTrue.add(state.examsQuestionResponse?.questions?[questionId].id);
                                                for (int i = 0; i < answerTrue.length; i++) {
                                                  (data[state.examsQuestionResponse?.questions?[i].categoryId.toString()]["correct"] as List).add({"pk": answerTrue.toList()[i]});
                                                }
                                              }
                                            }
                                            if (answerFalse.length == 1 && isError) {
                                              print('_TestSuccessScreenState.build ${getStorage.read("ie_error_test_first")}');
                                              if (getStorage.read("ie_error_test_first") == null) {
                                                getStorage.write("ie_error_test_first", true);
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                    builder: (context) {
                                                      return bottomSheetCustom(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon: "error_test",
                                                          title: "Felaktigt besvarade frågor",
                                                          desc: "Your account password has been updated, you can already login with your new password.");
                                                    });
                                              }
                                            }
                                          });
                                        },
                                        index: index,
                                        item: i,
                                        title: state.examsQuestionResponse?.questions?[questionId].variantSet?[i].text ?? "",
                                        isTrue: isChecking),
                                  if (!(isChecking ?? true)) const SizedBox(height: 16),
                                  if (!(isChecking ?? true))
                                    if(widget.timerAndData![2]!=4)
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(left: 25, right: 25),
                                      padding: const EdgeInsets.only(top: 22, left: 17, right: 17, bottom: 22),
                                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Oops! Ditt svar var inte rätt.", style: AppStyle.testCheck),
                                          const SizedBox(height: 6),
                                          Text(
                                            state.examsQuestionResponse?.questions?[questionId].answer ?? "",
                                            style: AppStyle.lessonButton2Grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                                    child: buttonLogin(
                                        onPressed: () async {
                                          if (state.examsQuestionResponse?.questions?[questionId].isSaved != null) {
                                            if (state.examsQuestionResponse?.questions?[questionId].isSaved != isSaved) {
                                              context.read<LessonBloc>().add(LessonTestEvent(testId: state.examsQuestionResponse?.questions?[questionId].id));
                                            }
                                          }
                                          if ((index ?? -1) >= 0) {
                                            count++;
                                            if (questionId + 1 < questionLength) {
                                              questionId++;
                                              isNext = true;
                                              _gifController.play();
                                              isFirstError = true;
                                              scrollFirst();
                                              isPlay = true;
                                              isSaved = state.examsQuestionResponse?.questions?[questionId].isSaved ?? false;
                                              index = -1;
                                              isChecking = null;
                                              // await Directory(gifViewMap[questionId - 1]).delete(recursive: true);
                                            } else {
                                              List wrong = [];
                                              List correct = [];
                                              data.forEach((key, value) {
                                                List wrong1 = value["wrong"];
                                                List correct1 = value["correct"];
                                                for (int i = 0; i < wrong1.length; i++) {
                                                  wrong.add((wrong1[i]));
                                                }
                                                for (int i = 0; i < correct1.length; i++) {
                                                  correct.add((correct1[i]));
                                                }
                                              });
                                              context
                                                  .read<CategoriesFilterBloc>()
                                                  .add(CategoriesAnswerPostEvent(wrongQuestions: wrong, correctQuestions: correct, examId: state.examsQuestionResponse?.examId));
                                              Navigator.pushNamed(context, RouteList.reviewScreen, arguments: {
                                                "questions": state.examsQuestionResponse?.questions?.length,
                                                "trueAnswers": answerTrue.length,
                                                "falseAnswers": answerFalse.length,
                                                "data": data,
                                                "timeTest": timeTest()
                                              }).then((value) async {

                                                Navigator.pop(context);
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
                            ],
                          ),
                        )),
                  )
                ],
              );
            } else {
              return const Center(
                child: Icon(Icons.do_not_disturb_alt),
              );
            }
          }
          else if (state is CategoriesMixFilterLoaded) {
            if (state.mixQuestionsResponseList!.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 26),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                              builder: (context) {
                                return bottomSheetCustom(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    icon: "exit_test",
                                    title: "Felaktigt besvarade frågor",
                                    desc: "Your account password has been updated, you can already login with your new password.");
                              });
                        },
                        child: SvgPicture.asset(
                          "assets/svg/back.svg",
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const Spacer(),
                      if (widget.timerAndData?[0] ?? false)
                        Container(
                          padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 13),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.testSuccess),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svg/clock.svg"),
                              const SizedBox(width: 4),
                              Text("${hours != "00" ? "$hours:" : ""}$minutes:$seconds"),
                            ],
                          ),
                        ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          saveCount++;
                          if (saveCount == 1) {
                            if (getStorage.read("is_saved") == null) {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                  builder: (context) {
                                    return bottomSheetCustom(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: "save_test",
                                        title: "Felaktigt besvarade frågor",
                                        desc: "Your account password has been updated, you can already login with your new password.");
                                  });
                              getStorage.write("is_saved", true);
                            }
                          }
                          isNext = false;

                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                        child: isSaved
                            ? SvgPicture.asset(
                                "assets/svg/save_done.svg",
                                height: 35,
                                width: 35,
                              )
                            : SvgPicture.asset(
                                "assets/svg/save.svg",
                                height: 35,
                                width: 35,
                              ),
                      ),
                      const SizedBox(width: 26),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 25, right: 3),
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(2)),
                            child: LinearProgressIndicator(
                              value: progress,
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF94D073)),
                              backgroundColor: const Color(0xffD6D6D6),
                            ),
                          ),
                        ),
                      ),
                      Text("$count/${(state.mixQuestionsResponseList?.length ?? 1)}", style: AppStyle.testProgress),
                      const SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 33.0),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics:const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.mixQuestionsResponseList?[questionId].questionGif != null)
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
                                            child: gifViewMapUnit.isNotEmpty
                                                ? gifViewMapUnit.length>=questionId+1
                                                    ?GifViewCustom.memory(
                                              gifViewMapUnit[questionId],
                                                        controller: _gifController,
                                                        progress: const Center(
                                                          child: CircularProgressIndicator(
                                                            color: AppColors.green,
                                                          ),
                                                        ),
                                                        isNext: isNext,
                                                      ): const Center(
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
                                        ],
                                      ),
                                    ),
                                  if (state.mixQuestionsResponseList?[questionId].questionGif == null && state.mixQuestionsResponseList?[questionId].questionImage != null)
                                    Image.network(
                                      state.mixQuestionsResponseList?[questionId].questionImage ?? "",
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  if (state.mixQuestionsResponseList?[questionId].questionGif != null || state.mixQuestionsResponseList?[questionId].questionImage != null) const SizedBox(height: 10),
                                  Text(
                                    state.mixQuestionsResponseList?[questionId].questionText ?? "",
                                    style: AppStyle.testStyle,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                for (int i = 0; i < (state.mixQuestionsResponseList?[questionId].variantSet?.length ?? 0); i++)
                                  testItem(
                                      onTap: () {
                                        setState(() {
                                          isNext = false;
                                          if ((isChecking ?? true) && isCorrect) {
                                            index = i;
                                            isCorrect = false;
                                          }
                                          if ((index ?? -1) >= 0) {
                                            isChecking = state.mixQuestionsResponseList?[questionId].variantSet?[index!].isCorrect;
                                            if (!isChecking!) {
                                              isError = true;
                                              if (isFirstError) {
                                                scroll();
                                                isFirstError = false;
                                              }
                                              List wrong = data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["wrong"];
                                              if (wrong.isEmpty) {
                                                data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["wrong"].add({"pk": state.mixQuestionsResponseList?[questionId].id});
                                              }
                                              for (int i = 0; i < wrong.length; i++) {
                                                if (!(wrong[i] as Map).containsValue(state.mixQuestionsResponseList?[questionId].id)) {
                                                  data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["wrong"].add({"pk": state.mixQuestionsResponseList?[questionId].id});
                                                }
                                              }
                                            } else {
                                              isError = false;
                                              List correct = data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["correct"];
                                              if (correct.isEmpty) {
                                                data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["correct"].add({"pk": state.mixQuestionsResponseList?[questionId].id});
                                              }
                                              for (int i = 0; i < correct.length; i++) {
                                                if (!(correct[i] as Map).containsValue(state.mixQuestionsResponseList?[questionId].id)) {
                                                  data[state.mixQuestionsResponseList?[questionId].categoryId.toString()]["correct"].add({"pk": state.mixQuestionsResponseList?[questionId].id});
                                                }
                                              }
                                            }
                                          }
                                          if (answerFalse.length == 1 && isError) {
                                            if (getStorage.read("ie_error_test") == null) {
                                              getStorage.write("is_error_test", true);
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                  builder: (context) {
                                                    return bottomSheetCustom(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        icon: "error_test",
                                                        title: "Felaktigt besvarade frågor",
                                                        desc: "Your account password has been updated, you can already login with your new password.");
                                                  });
                                            }
                                          }
                                        });
                                      },
                                      index: index,
                                      item: i,
                                      title: state.mixQuestionsResponseList?[questionId].variantSet?[i].text ?? "",
                                      isTrue: isChecking),
                                if (!(isChecking ?? true))
                                  if (widget.timerAndData?[2] != 4) const SizedBox(height: 16),
                                if (!(isChecking ?? true))
                                  if (widget.timerAndData?[2] != 4)
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(left: 25, right: 25),
                                      padding: const EdgeInsets.only(top: 22, left: 17, right: 17, bottom: 22),
                                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Oops! Ditt svar var inte rätt.", style: AppStyle.testCheck),
                                        const SizedBox(height: 6),
                                        Text(
                                          state.mixQuestionsResponseList?[questionId].answer ?? "",
                                          style: AppStyle.lessonButton2Grey,
                                        )
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: buttonLogin(
                                      onPressed: () async {
                                        if (state.mixQuestionsResponseList?[questionId].isSaved != null) {
                                          if (state.mixQuestionsResponseList?[questionId].isSaved != isSaved) {
                                            context.read<LessonBloc>().add(LessonTestEvent(testId: state.mixQuestionsResponseList?[questionId].id));
                                          }
                                        }
                                        if ((index ?? -1) >= 0) {
                                          count++;
                                          if (questionId + 1 < questionLength) {
                                            questionId++;
                                            isNext = true;
                                            _gifController.play();
                                            isFirstError = true;
                                            scrollFirst();
                                            isPlay = true;
                                            isSaved = state.mixQuestionsResponseList?[questionId].isSaved ?? false;
                                            index = -1;
                                            isChecking = null;
                                            print('_TestSuccessScreenState.build ${gifViewMapUnit.length}}');
                                            if (questionId % 5 == 0 && questionId % 10 != 0) {
                                              if (gifViewMapUnit.length + 10 > (state.mixQuestionsResponseList?.length ?? 0)) {
                                                return;
                                              }
                                              for (int i = gifViewMapUnit.length; i < gifViewMapUnit.length + 10; i++) {
                                                _downloadAndSavePhoto(state.mixQuestionsResponseList?[i].questionGif ?? "", i.toString());
                                              }
                                            }
                                            // final a = await Directory(gifViewMap[questionId-1]).delete(recursive: true);
                                            // print('_TestSuccessScreenState.build ${await a.exists()}');
                                          } else {
                                            List wrong = [];
                                            List correct = [];
                                            data.forEach((key, value) {
                                              for (int i = 0; i < (value["wrong"] as List).length; i++) {
                                                wrong.add((value["wrong"][i]));
                                              }
                                              for (int i = 0; i < (value["correct"] as List).length; i++) {
                                                correct.add((value["correct"][i]));
                                              }
                                            });
                                            if (widget.timerAndData![2] == 1) {
                                              context.read<CategoriesFilterBloc>().add(MixAnswersPostEvent(wrongQuestions: wrong, correctQuestions: correct));
                                            } else if (widget.timerAndData![2] == 2) {
                                              context.read<CategoriesFilterBloc>().add(WrongAnswersPostEvent(wrongQuestions: wrong, correctQuestions: correct));
                                            } else if (widget.timerAndData![2] == 3) {
                                              context.read<CategoriesFilterBloc>().add(SavedAnswersPostEvent(wrongQuestions: wrong, correctQuestions: correct));
                                            }

                                            Navigator.pushNamed(context, RouteList.reviewScreen, arguments: {
                                              "questions": wrong.length + correct.length,
                                              "trueAnswers": correct.length,
                                              "falseAnswers": wrong.length,
                                              "data": data,
                                              "timeTest": timeTest()
                                            }).then((value) {
                                              Navigator.pop(context);
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
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Icon(Icons.do_not_disturb_alt),
              );
            }
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

