import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/bloc/todo/todo_bloc.dart';
import 'package:korkort/style/app_style.dart';

import '../../../style/app_colors.dart';

class TodoUpScreen extends StatefulWidget {
  const TodoUpScreen({Key? key}) : super(key: key);

  @override
  State<TodoUpScreen> createState() => _TodoUpScreenState();
}

class _TodoUpScreenState extends State<TodoUpScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(TodoGetEvent());
    super.initState();
  }

  List todoList = [];
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteAccent,
        body: SafeArea(
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
                    "Getting a License",
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
                child: BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is TodoLoaded) {
                      return CustomRefreshIndicator(
                        onRefresh: () async {
                          page += 1;
                          context.read<TodoBloc>().add(TodoAddEvent(page: page));
                        },
                        trigger: IndicatorTrigger.trailingEdge,
                        trailingScrollIndicatorVisible: false,
                        leadingScrollIndicatorVisible: true,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                for (int i = 0; i < (state.todoResponse?.results?.length ?? 0); i++)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent, backgroundColor: AppColors.white, cardColor: Colors.red, canvasColor: Colors.red),
                                      child: ExpansionTile(
                                        expandedAlignment: Alignment.centerLeft,
                                        trailing: SvgPicture.asset("assets/svg/icon_more.svg"),
                                        leading: InkWell(
                                            onTap: () {
                                              if (todoList.contains(i)||(state.todoResponse?.results?[i].isCompleted??false)) {
                                                todoList.remove(i);
                                                context.read<TodoBloc>().add(TodoUpdateEvent(isCompleted: false, todo: state.todoResponse?.results?[i].id));
                                              } else {
                                                todoList.add(i);
                                                context.read<TodoBloc>().add(TodoUpdateEvent(isCompleted: true, todo: state.todoResponse?.results?[i].id));
                                              }
                                              setState(() {});
                                            },
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: SvgPicture.asset(
                                                "assets/svg/${todoList.contains(i)||(state.todoResponse?.results?[i].isCompleted??false) ? "check" : "test_circle"}.svg",
                                                height: 20,
                                                width: 20,
                                              ),
                                            )
                                            // Icon(
                                            //   todoList.contains(i) ? Icons.check_circle : Icons.circle_outlined,
                                            //   size: 20,
                                            //   color: todoList.contains(i) ? AppColors.greenAccent : AppColors.categoryGrey,
                                            // )
                                            ),
                                        backgroundColor: AppColors.white,
                                        iconColor: AppColors.blackIntro,
                                        childrenPadding: const EdgeInsets.only(bottom: 19, left: 16, right: 16),
                                        tilePadding: const EdgeInsets.only(left: 16, right: 19),
                                        title: Text((state.todoResponse?.results?[i].title ?? ""), style:todoList.contains(i)? AppStyle.titleOrdLine: AppStyle.titleOrd),
                                        children: <Widget>[
                                          Html(data: state.todoResponse?.results?[i].text),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        builder: (BuildContext context, Widget child, IndicatorController controller) {
                          return AnimatedBuilder(
                              animation: controller,
                              builder: (context, _) {
                                final dy = controller.value.clamp(0.0, 1.25) * -(150 - (150 * 0.25));
                                return Stack(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0.0, dy),
                                      child: child,
                                    ),
                                    Positioned(
                                      bottom: -150,
                                      left: 0,
                                      right: 0,
                                      height: 150,
                                      child: Container(
                                        transform: Matrix4.translationValues(0.0, dy, 0.0),
                                        padding: const EdgeInsets.only(top: 30.0),
                                        constraints: const BoxConstraints.expand(),
                                        child: Column(
                                          children: [
                                            if (controller.isLoading)
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 8.0),
                                                width: 16,
                                                height: 16,
                                                child: const CircularProgressIndicator(
                                                  color: AppColors.green,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            else
                                              const CircularProgressIndicator(
                                                color: AppColors.green,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.green,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
