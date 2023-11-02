import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/screens/main/home/widget.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/lesson/lesson_bloc.dart';
import '../../../route/route_constants.dart';
import '../../../style/app_style.dart';
import 'chart_screen.dart';

class LessonScreen extends StatefulWidget {
  final int? id;

  LessonScreen({Key? key, this.id}) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  ScrollController scrollController = ScrollController();
  final sliverListKey = GlobalKey();
  int index = 1;
  String language = "en";
  int? id;
  NumberFormat formatter = NumberFormat("00");
  int? lastLessonId;
  int? oldLessonId;
  bool? isNext = false;
  late VideoPlayerController _videoPlayerController;

  late CustomVideoPlayerController _customVideoPlayerController;

  CustomVideoPlayerSettings? _customVideoPlayerSettings;
  bool isDoneVideo = false;
  late final itemScrollController ;
  ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  late final itemPositionsListener ;
  ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
 int topListItem=0;
  @override
  void initState() {
    itemScrollController=ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: 1);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    // _videoPlayerController.dispose();
    super.dispose();
  }

  void checkVideo() async {
    if (_videoPlayerController.value.position != const Duration(seconds: 0, minutes: 0, hours: 0)) {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        await _videoPlayerController.seekTo(const Duration(seconds: 0));
        await _videoPlayerController.pause();
        setState(() {
          isVideoEnd = true;
        });
      }
    }
  }

  bool isVideoEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<LessonBloc, LessonState>(
        listener: (context, state) {
          if (state is LessonLoaded) {
            id = state.lessonResponse?.id;
            for (int i = 0; i < (state.lessonResponse?.lessons?.length ?? 0); i++) {
              if(state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3 && state.lessonResponse?.lessons?[i].id == id){
                topListItem=i;
              }
              if (i + 1 < (state.lessonResponse?.lessons?.length ?? 0) && (i - 1) > 0) {
                if (state.lessonResponse?.lessons?[i].id == id) {
                  if (state.lessonResponse?.lessons?[i + 1].lessonPermission == 4) {
                    isNext = true;
                  } else {
                    isNext = false;
                  }
                  if (state.lessonResponse?.lessons?[i + 1].lessonPermission != 4 && (state.lessonResponse?.lessons?[i + 1].lessonPermission != 3)) {
                    lastLessonId = state.lessonResponse?.lessons?[i + 1].id;
                  }
                  oldLessonId = state.lessonResponse?.lessons?[i - 1].id;
                }
              } else if (i - 1 > 0) {
                if (state.lessonResponse?.lessons?[i].id == id) {
                  lastLessonId = state.lessonResponse?.lessons?[i + 1].id;
                  oldLessonId = null;
                  print('_LessonScreenState.build lastLessonId 11:$lastLessonId oldLessonId:$oldLessonId');
                }
              }
              setState(() {});
              print('_LessonScreenState.build lastLessonId:$lastLessonId oldLessonId:$oldLessonId');
            }
            _customVideoPlayerSettings = CustomVideoPlayerSettings(
              showSeekButtons: true,
              customAspectRatio: 1.6,
              placeholderWidget: AspectRatio(
                aspectRatio: 1.6,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      state.lessonResponse?.image ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      // opacity: const AlwaysStoppedAnimation(.5),

                      // height: double.infinity,
                    ),
                    Positioned(child: Container(
                      color: AppColors.black.withOpacity(0.5),
                    )),
                    const Positioned(
                        child: SizedBox(
                            height:30,width: 30,child: CircularProgressIndicator(color: AppColors.greenAccent,)))
                  ],
                ),
              ),
              alwaysShowThumbnailOnVideoPaused: false,
              showPlayButton: true,
              thumbnailWidget: Image.network(
                state.lessonResponse?.image ?? "",
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              playOnlyOnce: false,
            );
            _videoPlayerController = VideoPlayerController.network(
              state.lessonResponse?.video ?? "",
            )
              ..initialize().then((value) => setState(() {
                    isDoneVideo = true;
                  }))
              ..addListener(() {
                setState(() {
                  checkVideo();
                });
              });
            _customVideoPlayerController = CustomVideoPlayerController(
              context: context,
              videoPlayerController: _videoPlayerController,
              customVideoPlayerSettings: _customVideoPlayerSettings!,
            );
          }
        },
        builder: (context, state) {
          if (state is LessonLoaded) {
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      color: AppColors.whiteAccent,
                      height: 44,
                    ),
                    Container(
                      color: AppColors.whiteAccent,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              if (oldLessonId != null) {
                                context.read<LessonBloc>().add(LessonIdEvent(id: oldLessonId));
                                _videoPlayerController.pause();
                              }
                            },
                            child: SvgPicture.asset(
                              "assets/svg/back_left.svg",
                              color: oldLessonId == null ? AppColors.grey1 : AppColors.green,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Träningsprov",
                            style: AppStyle.appBarStyle,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (lastLessonId != null) {
                                context.read<LessonBloc>().add(LessonIdEvent(id: lastLessonId));
                                _videoPlayerController.pause();}
                            },
                            child: SvgPicture.asset("assets/svg/back_right.svg", color: lastLessonId == null ? AppColors.grey1 : AppColors.green),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      color: AppColors.whiteAccent,
                    ),
                    Container(
                      height: 20,
                      color: AppColors.whiteAccent,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: ScrollablePositionedList.builder(
                          physics:const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.lessonResponse?.lessons?.length ?? 0,
                          initialScrollIndex: topListItem,
                          itemScrollController: itemScrollController,
                          scrollOffsetController: scrollOffsetController,
                          itemPositionsListener: itemPositionsListener,
                          scrollOffsetListener: scrollOffsetListener,
                          itemBuilder: (context, i) =>
                              Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (state.lessonResponse?.lessons?[i].lessonPermission != 4 &&
                                                    state.lessonResponse?.lessons?[i].lessonPermission != 3 &&
                                                    state.lessonResponse?.lessons?[i].id == id) {
                                                  _videoPlayerController.pause();

                                                } else if (state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3) {
                                                  context.read<LessonBloc>().add(LessonIdEvent(id: state.lessonResponse?.lessons?[i].id));
                                                  _videoPlayerController.pause();

                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/svg/play${state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3 && state.lessonResponse?.lessons?[i].id == id ? "_green" : state.lessonResponse?.lessons?[i].lessonPermission != 4 && ((state.lessonResponse?.lessons?[i].lessonPermission != 3)) ? "_off" : ""}"
                                                  ".svg",
                                                  height: 20,
                                                  width: 20)),
                                          const SizedBox(width: 5),
                                          SvgPicture.asset(
                                            "assets/svg/horizantal.svg",
                                            color: state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3 ? AppColors.green : AppColors.grey1,
                                          ),
                                          const SizedBox(width: 5),
                                          InkWell(
                                              onTap: () {
                                                if (state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3) {
                                                  Navigator.pushNamed(context, RouteList.testScreen, arguments: [state.lessonResponse?.id, widget.id, isNext]);
                                                  _videoPlayerController.pause();
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/svg/load${state.lessonResponse?.lessons?[i].lessonPermission != 4 && state.lessonResponse?.lessons?[i].lessonPermission != 3 ? "_green" : ""}.svg",
                                                  height: 20,
                                                  width: 20)),
                                          const SizedBox(width: 5),
                                          SvgPicture.asset("assets/svg/horizantal.svg"),
                                          const SizedBox(width: 5),
                                        ],
                                      )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(color: AppColors.whiteAccent, height: 15),
                  ],
                ),
                if (!isVideoEnd)
                  //     if(isDoneVideo)
                  CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
                if (isVideoEnd)
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: ChartScreen(
                      onTapNext: () {
                        Navigator.pushNamed(context, RouteList.testScreen, arguments: [state.lessonResponse?.id, widget.id, isNext]);
                        isVideoEnd = false;
                      },
                      onTapReplay: () {
                        setState(() {
                          isVideoEnd = false;
                        });
                      },
                      id: id,
                    ),
                  ),
                Expanded(
                  flex: 7,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    slivers: [
                      if (state.lessonResponse?.title != "" || state.lessonResponse?.text != "")
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              if (isVideoEnd) const SizedBox(height: 10),
                              if (isVideoEnd)
                                Padding(
                                  padding: const EdgeInsets.only(right: 25.0, left: 25),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isVideoEnd = false;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.white, border: Border.all(color: AppColors.green)),
                                          child: Center(
                                            child: Text(
                                              "Replay video",
                                              style: AppStyle.lessonButtonGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, RouteList.testScreen, arguments: [state.lessonResponse?.id, widget.id, isNext]);
                                          isVideoEnd = false;
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: AppColors.green,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Go to quize",
                                              style: AppStyle.loginRegister1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0, left: 25, bottom: 8),
                                child: Text(
                                  state.lessonResponse?.title ?? "",
                                  style: AppStyle.lessonTitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0, left: 25),
                                child: ExpandableText(
                                  state.lessonResponse?.text ?? "",
                                  trimType: TrimType.characters,
                                  trim: 350, // trims if text exceeds 20 characters
                                ),
                              ),
                            ],
                          ),
                        ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                          child: Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: AppColors.tabBar, width: 2))),
                            child: TabBar(
                              onTap: (val) {
                                setState(() {
                                  index = val;
                                });
                              },
                              unselectedLabelColor: Colors.grey.shade700,
                              indicatorColor: AppColors.green,
                              indicatorWeight: 2.0,
                              labelColor: AppColors.blackIntro,
                              controller: _tabController,
                              tabs: const <Widget>[
                                Tab(text: 'Ordlista'),
                                Tab(text: 'Lektioner'),
                                Tab(text: 'Resurs'),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        key: sliverListKey,
                        delegate: SliverChildListDelegate(
                          [
                            if (index == 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0, right: 25),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    for (int i = 0; i < (state.lessonResponse?.wordInfos?.length ?? 0); i++)
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 32,
                                            spreadRadius: 0,
                                            offset: Offset(0, 4),
                                            color: Color.fromRGBO(0, 0, 0, 0.04),
                                          )
                                        ]),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            backgroundColor: AppColors.white,
                                            iconColor: AppColors.blackIntro,
                                            childrenPadding: const EdgeInsets.only(bottom: 19, left: 16, right: 16),
                                            tilePadding: const EdgeInsets.only(left: 16, right: 19),
                                            title: Text(state.lessonResponse?.wordInfos?[i].word ?? "", style: AppStyle.titleOrd),
                                            children: <Widget>[
                                              Text(
                                                state.lessonResponse?.wordInfos?[i].info ?? "",
                                                style: AppStyle.textOrd,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            if (index == 1)
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0, right: 25),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    for (int i = 0; i < (state.lessonResponse?.lessons?.length ?? 0); i++)
                                      lessonButton(
                                          isActive: state.lessonResponse?.lessons?[i].lessonPermission != 3 && state.lessonResponse?.lessons?[i].lessonPermission != 4,
                                          id: state.lessonResponse?.lessons?[i].id,
                                          index: i + 1,
                                          lessonPermissionId: state.lessonResponse?.lessons?[i].lessonPermission,
                                          name: state.lessonResponse?.lessons?[i].title,
                                          time: state.lessonResponse?.lessons?[i].lessonTime,
                                          isCompleted: state.lessonResponse?.lessons?[i].isCompleted,
                                          isOpen: state.lessonResponse?.lessons?[i].isOpen,
                                          onlineId: state.lessonResponse?.id,
                                          onTap: () {
                                            if (state.lessonResponse?.lessons?[i].lessonPermission == 4 || state.lessonResponse?.lessons?[i].lessonPermission == 3) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                                                  builder: (context) {
                                                    return Container(
                                                        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                                        // height: MediaQuery.of(context).size.height * 0.7,
                                                        child: bottomSheetGoTariff(
                                                            onTap: () {
                                                              Navigator.pushNamed(context, RouteList.tariffScreen);
                                                            },
                                                            onTapExit: () {
                                                              Navigator.pop(context);
                                                            },
                                                            context: context));
                                                  });
                                            } else if (state.lessonResponse?.lessons?[i].lessonPermission != 3) {
                                              context.read<LessonBloc>().add(LessonIdEvent(id: state.lessonResponse?.lessons?[i].id));
                                              _videoPlayerController.pause();
                                            }
                                          }),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            if (index == 2)
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0, left: 25),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    for (int i = 0; i < (state.lessonResponse?.sources?.length ?? 0); i++)
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            launchUrl(Uri.parse(state.lessonResponse?.sources?[i].link ?? ""));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 15),
                                            child: Text(
                                              state.lessonResponse?.sources?[i].text ?? "",
                                              style: const TextStyle(
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          return Container(
            color: AppColors.whiteAccent,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}



