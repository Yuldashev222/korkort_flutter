import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/style/app_style.dart';

import '../../../bloc/book/book_bloc.dart';
import '../../../style/app_colors.dart';
List todoList =[];

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  void initState() {
    context.read<BookBloc>().add(BookGetEvent());
    super.initState();
  }
bool isCompleted1=false;
int page =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteAccent,
        body: SafeArea(
          child: BlocConsumer<BookBloc, BookState>(
            listener: (context, state) {
              if(state is BookLoaded){
                for (int i = 0; i < (state.booksResponse?.results?.length ?? 0); i++){
                  for (int j = 0; j < (state.booksResponse?.results?[i].chapters?.length ?? 0); j++){
                    if((state.booksResponse?.results?[i].chapters?[j].isCompleted??false)){
                      todoList.add("$i $j");
                    }
                  }
                }
              }
            },
            builder: (context, state) {
              if(state is BookLoaded ){
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "The Driving License Book",
                        style: AppStyle.appBarStyle12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: CustomRefreshIndicator(
                    onRefresh: () async {
                      page+=1;
                      context.read<BookBloc>().add(BookAddEvent(page: page));
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
                            for (int i = 0; i < (state.booksResponse?.results?.length ?? 0); i++)
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/svg/book.svg"),
                                      const SizedBox(width: 9),
                                      Text(
                                        state.booksResponse?.results?[i].title ?? "",
                                        style: AppStyle.appBarStyle12,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  for (int j = 0; j < (state.booksResponse?.results?[i].chapters?.length ?? 0); j++)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, RouteList.book,arguments: [i,j]).then((value) {
                                            setState(() {});
                                          });
                                          context.read<BookBloc>().add(BookGetIdEvent(id: state.booksResponse?.results?[i].chapters?[j].id??0));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(top: 10, left: 17, bottom: 10, right: 18),
                                          // height: 40,
                                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text(state.booksResponse?.results?[i].chapters?[j].title ?? "", style: AppStyle.bookTitle)),
                                              // const Spacer(),
                                              InkWell(onTap: () {
                                                if(todoList.contains("$i $j")){
                                                  todoList.remove("$i $j");
                                                  context.read<BookBloc>().add(BookChaptersUpdateEvent(chapter: state.booksResponse?.results?[i].chapters?[j].id??0,isCompleted: false));
                                                }else{
                                                  todoList.add("$i $j");
                                                  context.read<BookBloc>().add(BookChaptersUpdateEvent(chapter: state.booksResponse?.results?[i].chapters?[j].id??0,isCompleted: true));
                                                }
                                                setState(() {});
                                              },
                                                  child:
                                                  (state.booksResponse?.results?[i].chapters?[j].isOpen ?? false) == false ?
                                                  SvgPicture.asset(
                                                    "assets/svg/carona_green.svg",
                                                    height: 20,width: 20,
                                                  ):
                                                  SvgPicture.asset(
                                                    "assets/svg/${todoList.contains("$i $j") ? "check" : "test_circle"}.svg",
                                                    height: 20,width: 20,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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
                  )),

                ],
              );}
              return const Center(child: CircularProgressIndicator(color: AppColors.green,),);
            },
          ),
        ));
  }
}
