import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/screens/main/book_screen/book_list_screen.dart';
import 'package:korkort/style/app_colors.dart';

import '../../../bloc/book/book_bloc.dart';
import '../../../style/app_style.dart';

class BookScreen extends StatefulWidget {
  final List? data;

  const BookScreen({Key? key, this.data}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  bool isScroll = true;
  bool isAudio = true;
  bool isCompleted = false;
  int dur = 0;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Duration maxDuration = const Duration(seconds: 0);

  getMaxDuration() {
    audioPlayer.getDuration().then((value) {
      maxDuration = value ?? const Duration(seconds: 0);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels < 30.0 && !isScroll) {
        setState(() {
          isScroll = true;
        });
      } else if (scrollController.position.pixels > 30.0 && isScroll) {
        setState(() {
          isScroll = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteAccent,
        body: SafeArea(
          child: BlocConsumer<BookBloc, BookState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is BookLoaded) {
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              for (int i = 0; i < (state.booksIdResponse?.parts?.length ?? 0); i++)
                                Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/svg/book.svg"),
                                        const SizedBox(width: 9),
                                        Expanded(
                                          child: Text(
                                            state.booksIdResponse?.parts?[i].title ?? "",
                                            style: AppStyle.appBarStyle12,
                                            maxLines: 4,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 23),
                                    Image.network(state.booksIdResponse?.parts?[i].image ?? ''),
                                    const SizedBox(height: 13),
                                    Html(data: state.booksIdResponse?.parts?[i].text),
                                    if (state.booksIdResponse?.parts?[i].greenText != null && state.booksIdResponse?.parts?[i].greenText != "") const SizedBox(height: 12),
                                    if (state.booksIdResponse?.parts?[i].greenText != null && state.booksIdResponse?.parts?[i].greenText != "")
                                      Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.greenDark),
                                          padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 14),
                                          child: Html(data: state.booksIdResponse?.parts?[i].greenText)),
                                    if (state.booksIdResponse?.parts?[i].yellowText != null && state.booksIdResponse?.parts?[i].yellowText != "") const SizedBox(height: 12),
                                    if (state.booksIdResponse?.parts?[i].yellowText != null && state.booksIdResponse?.parts?[i].yellowText != "")
                                      Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.yellowDark),
                                          padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 14),
                                          child: Html(data: state.booksIdResponse?.parts?[i].yellowText)),
                                    if (state.booksIdResponse?.parts?[i].redText != null && state.booksIdResponse?.parts?[i].redText != "") const SizedBox(height: 12),
                                    if (state.booksIdResponse?.parts?[i].redText != null && state.booksIdResponse?.parts?[i].redText != "")
                                      Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.redDark),
                                          padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 14),
                                          child: Html(data: state.booksIdResponse?.parts?[i].redText)),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              InkWell(
                                onTap: () {
                                  if ( todoList.contains("${widget.data?[0]} ${widget.data?[1]}")) {
                                    todoList.remove("${widget.data?[0]} ${widget.data?[1]}");
                                    context.read<BookBloc>().add(BookChaptersUpdateEvent(chapter: (state.booksIdResponse?.id ?? 0), isCompleted: false));
                                  } else {
                                    todoList.add("${widget.data?[0]} ${widget.data?[1]}");
                                    context.read<BookBloc>().add(BookChaptersUpdateEvent(chapter: (state.booksIdResponse?.id ?? 0), isCompleted: true));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color:  todoList.contains("${widget.data?[0]} ${widget.data?[1]}") ? AppColors.green : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: AppColors.green)),
                                  child: Center(
                                    child: Text(
                                      todoList.contains("${widget.data?[0]} ${widget.data?[1]}")  ? "Make Uncompleted" : "Completed",
                                      style: todoList.contains("${widget.data?[0]} ${widget.data?[1]}")  ? AppStyle.completedOff : AppStyle.completed,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        child: Container(
                      decoration: isAudio && isScroll
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFFFF8E6),
                                  Color.fromRGBO(217, 217, 217, 0.00),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ))
                          : const BoxDecoration(
                              gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFF8E6),
                                Color.fromRGBO(217, 217, 217, 0.00),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                      width: MediaQuery.of(context).size.width,
                      child: isAudio
                          ? (isScroll
                              ? Container(
                                  margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
                                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                  // height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/back_left.svg",
                                          width: 40,
                                          height: 40,
                                          color: AppColors.green,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        constraints: const BoxConstraints(maxWidth: 200, minWidth: 50),
                                        child: Text(
                                          state.booksIdResponse?.title ?? '',
                                          style: AppStyle.appBarStyle12,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isAudio = false;
                                          });
                                          await audioPlayer.play(UrlSource(state.booksIdResponse!.audio!));
                                          getMaxDuration();
                                          await audioPlayer.pause();
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/audio_play.svg",
                                          width: 40,
                                          height: 40,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : AnimatedContainer(
                                  margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
                                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                  // height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.white,
                                      boxShadow: const [BoxShadow(offset: Offset(0, 4), blurRadius: 7, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.10))]),
                                  duration: const Duration(milliseconds: 500),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/back_left.svg",
                                          width: 40,
                                          height: 40,
                                          color: AppColors.green,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Däckbyte",
                                        style: AppStyle.appBarStyle12,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          isAudio = false;
                                          await audioPlayer.play(UrlSource(state.booksIdResponse!.audio!));
                                          getMaxDuration();
                                          await audioPlayer.pause();

                                          setState(() {});
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/audio_play.svg",
                                          width: 40,
                                          height: 40,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          : AnimatedContainer(
                              margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
                              padding: const EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 0),
                              // height: 100,
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(maxHeight: 80, minHeight: 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.white,
                                  boxShadow: const [BoxShadow(offset: Offset(0, 4), blurRadius: 7, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.10))]),
                              duration: const Duration(milliseconds: 500),
                              child: Center(
                                child: StreamBuilder(
                                    stream: audioPlayer.onPositionChanged,
                                    builder: (context, snapshot) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SvgPicture.asset("assets/svg/arrow_forward.svg")),
                                              InkWell(
                                                  onTap: () {
                                                    audioPlayer.seek(snapshot.data! - const Duration(seconds: 10));
                                                  },
                                                  child: SizedBox(height: 20, width: 20, child: SvgPicture.asset("assets/svg/replay_10.svg"))),
                                              StreamBuilder(
                                                  stream: audioPlayer.onPlayerStateChanged,
                                                  builder: (context, snapshot2) {
                                                    return InkWell(
                                                        onTap: () async {
                                                          if (snapshot2.data == PlayerState.playing) {
                                                            await audioPlayer.pause();
                                                            // isPlaying = false;
                                                          } else {
                                                            // isPlaying = true;
                                                            await audioPlayer.resume();
                                                            // await audioPlayer.play(UrlSource("https://luan.xyz/files/audio/ambient_c_motion.mp3"));
                                                          }
                                                        },
                                                        child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: SvgPicture.asset(snapshot2.data == PlayerState.playing ? "assets/svg/pause1.svg" : "assets/svg/play__on.svg")));
                                                  }),
                                              InkWell(
                                                  onTap: () {
                                                    audioPlayer.seek(snapshot.data! + const Duration(seconds: 10));
                                                  },
                                                  child: SizedBox(height: 20, width: 20, child: SvgPicture.asset("assets/svg/forward_10.svg"))),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isAudio = true;
                                                      audioPlayer.stop();
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                      "assets/svg/close1.svg",
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 9),
                                          Center(
                                            child: ProgressBar(
                                              progress: snapshot.data ?? const Duration(seconds: 0),
                                              buffered: const Duration(seconds: 5),
                                              total: maxDuration,
                                              onDragStart: (s) {},
                                              onDragEnd: () {},
                                              onDragUpdate: (a) {},
                                              thumbCanPaintOutsideBar: false,
                                              thumbRadius: 10,
                                              thumbGlowRadius: 15,
                                              barHeight: 6,
                                              thumbColor: AppColors.greenAccent,
                                              bufferedBarColor: AppColors.greenAccent.withOpacity(0.2),
                                              progressBarColor: AppColors.greenAccent,
                                              baseBarColor: AppColors.testSuccess,
                                              timeLabelTextStyle: AppStyle.totalTime,
                                              barCapShape: BarCapShape.round,
                                              timeLabelLocation: TimeLabelLocation.sides,
                                              onSeek: (duration) {
                                                audioPlayer.seek(duration);
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                    ))
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
        ));
  }
}
