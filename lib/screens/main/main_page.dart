import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korkort/bloc/categories_exams/categories_exams_bloc.dart';
import 'package:korkort/screens/main/book_screen/book_list_screen.dart';
import 'package:korkort/screens/main/profile_screen/profile_screen.dart';
import 'package:korkort/screens/main/success/success_screen.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import '../../route/route_constants.dart';
import '../../pdf_generate.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool isLogin = false;
  bool isEye = true;
  double progress = 0.1;
  int indexCurrent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: indexCurrent == 1
          ? const SuccessScreen()
          : indexCurrent == 2
              ? Container()
              : indexCurrent == 3
                  ? const BookListScreen()
                  : indexCurrent == 4
                      ? const ProfileScreen()
                      : const HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (e) {
          setState(() {
            indexCurrent = e;
          });
          if(indexCurrent==1){
            context.read<CategoriesExamsBloc>().add(CategoriesExamsGetEvent());
          }else if(indexCurrent==3){
            // Navigator.pushNamed(context, RouteList.tariffScreen);
          }
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
        iconSize: 20,
        selectedFontSize: 20,
        unselectedFontSize: 20,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/svg/home.svg", color: AppColors.green),
            icon: SvgPicture.asset("assets/svg/home.svg"),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/svg/explore.svg", color: AppColors.green),
            icon: SvgPicture.asset("assets/svg/explore.svg"),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/svg/list.svg", color: AppColors.green),
            icon: SvgPicture.asset("assets/svg/list.svg"),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/svg/notification.svg", color: AppColors.green),
            icon: SvgPicture.asset("assets/svg/notification.svg"),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/svg/profile.svg", color: AppColors.green),
            icon: SvgPicture.asset("assets/svg/profile.svg"),
            label: "",
          ),
        ],
        currentIndex: indexCurrent,
      ),
    );
  }
}
