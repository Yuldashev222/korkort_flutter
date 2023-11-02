import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/bloc/level/level_bloc.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_style.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  void initState() {
    context.read<LevelBloc>().add(LevelGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteAccent,
        body: BlocConsumer<LevelBloc, LevelState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if(state is LevelLoaded){
              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 30),
                        GestureDetector(
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
                          "Vägen till körkort",
                          style: AppStyle.appBarStyle12,
                        ),
                        const Spacer(),
                        const SizedBox(
                          height: 40,
                          width: 40,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Text("Level information")
                                ],
                              ),
                              const SizedBox(height: 8),
                              for (int i = 1; i <= (state.levelList?.length??0); i++)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: AppColors.testSuccess,
                                            radius: 22,
                                          ),
                                          Positioned(
                                              child: SvgPicture.asset(
                                            "assets/svg_level/level$i.svg",
                                            width: 44,
                                          ))
                                        ],
                                      ),
                                      const SizedBox(width: 14),
                                      Text(
                                        "${state.levelList?[i - 1].name}",
                                        style: AppStyle.levelStyle,
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        "assets/png/ball.png",
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "+${50 + i * 50}",
                                        style: AppStyle.levelBallStyle,
                                      ),
                                      const SizedBox(width: 33),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(color: AppColors.green,),);
          },
        ));
  }
}
