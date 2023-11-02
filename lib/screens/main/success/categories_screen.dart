import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/screens/main/success/widget.dart';
import 'package:korkort/style/app_colors.dart';

import '../../../bloc/categories_exams/categories_exams_bloc.dart';
import '../../../style/app_style.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  double progress = 0;
  Map data = {};
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoriesExamsBloc>().add(CategoriesExamsGetEvent());

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: SvgPicture.asset("assets/svg/back_left.svg"),
        //   ),
        // ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset("assets/svg/back_left.svg"),
            ),
            Text("Träningsprov",style: AppStyle.appBarStyle,),
            GestureDetector(
              onTap: () {
              },
              child: SvgPicture.asset("assets/svg/help.svg"),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.whiteAccent,
      ),
      body: BlocConsumer<CategoriesExamsBloc, CategoriesExamsState>(
        listener: (context, state) {
      if (state is CategoriesExamsLoaded) {
        for (int i = 0; i < (state.categoriesExamsResponse?.categoryExams?.length ?? 0); i++) {
          data.addAll({
            (state.categoriesExamsResponse?.categoryExams?[i].category.toString() ?? ""): {"correct": [], "wrong": [], "name": (state.categoriesExamsResponse?.categoryExams?[i].name ?? "")},
          });
        }
      }
        },
        builder: (context, state) {
          if (state is CategoriesExamsLoaded) {
            return SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 36.0,left: 36,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < (state.categoriesExamsResponse?.categoryExams?.length ?? 0); i++)
                      InkWell(
                        onTap: (){
                          testScreenForCategories(context: context, categoryId: state.categoriesExamsResponse?.categoryExams?[i].category, data: data);
                        },
                        child: Container(
                          height: 151,
                          // width: 302,
                          // padding: const EdgeInsets.only(top: 17, right: 17, left: 14, bottom: 8),
                          margin: const EdgeInsets.only(right: 10,bottom: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              // color: AppColors.red,
                              image: DecorationImage(image: NetworkImage(state.categoriesExamsResponse?.categoryExams?[i].image ?? ""), fit: BoxFit.cover),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(0, 0, 0, 0.86),
                                Color.fromRGBO(34, 43, 69, 0.00),
                              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(0, 0, 0, 0.86),
                                      Color.fromRGBO(34, 43, 69, 0.00),
                                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 17, right: 17, left: 14, bottom: 8),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                state.categoriesExamsResponse?.categoryExams?[i].name ?? "",
                                                style: AppStyle.loginButton,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Text(
                                              "20 Frågor",
                                              style: AppStyle.cart,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        state.categoriesExamsResponse!.categoryExams![i].detail!.isNotEmpty?
                                        InkWell(
                                          onTap: (){
                                            progressVerticalCategories(context: context, detail: state.categoriesExamsResponse!.categoryExams![i].detail );
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Text(
                                                "${state.categoriesExamsResponse?.categoryExams?[i].percent ?? 0}%",
                                                style: AppStyle.progress1,
                                              ),
                                              CircularProgressIndicator(
                                                value: (state.categoriesExamsResponse?.categoryExams?[i].percent ?? 0) / 100,
                                                color: AppColors.green,
                                                backgroundColor: AppColors.progressColor,
                                              ),
                                            ],
                                          ),
                                        ):SvgPicture.asset("assets/svg/circle_play.svg")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const   SizedBox(height: 30)

                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          );
        },
      ),
    );
  }
}
