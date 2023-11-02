import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/screens/main/profile_screen/profile_item.dart';
import 'package:korkort/widgets/button_login.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_style.dart';
import '../../auth/input_widget.dart';

class EditeProfileScreen extends StatefulWidget {
  final ProfileResponse?profileResponse;
  const EditeProfileScreen({Key? key,this.profileResponse}) : super(key: key);

  @override
  State<EditeProfileScreen> createState() => _EditeProfileScreenState();
}

class _EditeProfileScreenState extends State<EditeProfileScreen> with TickerProviderStateMixin {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool isLoginPasswordError1 = false;
  bool isLoginPasswordError2 = false;
  String? firstName;
  String? lastName;
  String? password1;
  String? password2;
  bool isFieldPassword1 = false;
  bool isFieldPassword2 = false;
  bool isFieldFirstName = false;
  bool isFieldLasName = false;
  bool isEye0 = true;
  bool isEye1 = true;
  bool isSwitch = false;
  num avatarItem = 0;
  bool isLoaded = false;
  late final itemScrollController ;
   ScrollOffsetController scrollOffsetController = ScrollOffsetController();
    late final itemPositionsListener ;
   ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  @override
  void initState() {
    itemScrollController=ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    setData();
    super.initState();
    // context.read<ProfileBloc>().add(ProfileGetEvent());

  }
   setData(){
     // setState(() {
       isLoaded = true;
       if (widget.profileResponse?.firstName != null) {
         firstNameController.text = widget.profileResponse!.firstName!;
         isFieldFirstName = true;
       }
       if (widget.profileResponse?.lastName != null) {
         lastNameController.text = widget.profileResponse!.lastName!;
         isFieldLasName = true;
       }
       avatarItem = widget.profileResponse?.avatarId ?? 0;


       // itemScrollController.scrollTo(index: 2
       //     // (widget.profileResponse?.avatarId ?? 1).toInt() - 1
       //     , duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
     // if((widget.profileResponse?.avatarId??0)>2) {
     //   itemScrollController.scrollTo(index: 2
     //   // (widget.profileResponse?.avatarId ?? 1).toInt() - 1
     //       , duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
     // }
     // });
   }
   @override
  void didChangeDependencies() {
     super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteAccent,
      appBar: AppBar(
        backgroundColor: AppColors.whiteAccent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/svg/arrow_left2.svg")),
        title: Text("Edit Profile", style: AppStyle.editeProfile),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            setState(() {
                isLoaded = true;
              if (state.profileResponse?.firstName != null) {
                firstNameController.text = state.profileResponse!.firstName!;
                isFieldFirstName = true;
              }
              if (state.profileResponse?.lastName != null) {
                lastNameController.text = state.profileResponse!.lastName!;
                isFieldLasName = true;
              }
              avatarItem = state.profileResponse?.avatarId ?? 0;
            });
            if((state.profileResponse?.avatarId??0)>2&&itemScrollController.isAttached ) {
              itemScrollController.scrollTo(index: (state.profileResponse?.avatarId ?? 1).toInt() - 1, duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
            }
          }
          else if (state is ProfileUpdateLoaded) {
            Navigator.pop(context);
            GetStorage().write("avatarItem", avatarItem);
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                builder: (context) {
                  return bottomSheetProfileUpdate(onPressed: () {
                    Navigator.pop(context);
                  });
                });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: CircleAvatar(
                    radius: 72,
                    backgroundColor: AppColors.white,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
                            builder: (context) {
                              return Container(
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                                  child: const DeployImageEditeProfileScreen(
                                    dataInfo: {},
                                  ));
                            });
                      },
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                "assets/svg_avatar/avatar$avatarItem.svg",
                                height: 90,
                                width: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                flex: 7,
                child: Container(
                  // padding: const EdgeInsets.only(
                  //   right: 24.0,
                  //   left: 24,
                  // ),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)), color: AppColors.white),
                  child: SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            right: 24.0,
                            left: 24,
                          ),
                          child: inputFullNameWidget(
                            textEditingController: firstNameController,
                            hint: "First name",
                            onChanged: (e) {
                              setState(() {});
                            },
                            validate: firstName,
                            onTap: () {
                              setState(() {
                                isFieldFirstName = true;
                              });
                              if (passwordController1.text.isEmpty) {
                                isFieldPassword1 = false;
                              }
                              if (passwordController2.text.isEmpty) {
                                isFieldPassword2 = false;
                              }

                              if (lastNameController.text.isEmpty) {
                                isFieldLasName = false;
                              }
                            },
                            isField: isFieldFirstName,
                            onFieldSubmitted: () {
                              if (firstNameController.text.isEmpty) {
                                setState(() {
                                  isFieldFirstName = false;
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24.0, top: 24),
                          child: inputFullNameWidget(
                            textEditingController: lastNameController,
                            hint: "Last name",
                            onChanged: (e) {
                              setState(() {});
                            },
                            validate: lastName,
                            onTap: () {
                              setState(() {
                                isFieldLasName = true;
                              });
                              if (passwordController1.text.isEmpty) {
                                isFieldPassword1 = false;
                              }
                              if (passwordController2.text.isEmpty) {
                                isFieldPassword2 = false;
                              }
                              if (firstNameController.text.isEmpty) {
                                isFieldFirstName = false;
                              }
                            },
                            isField: isFieldLasName,
                            onFieldSubmitted: () {
                              if (lastNameController.text.isEmpty) {
                                setState(() {
                                  isFieldLasName = false;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            children: [
                              if (!isSwitch) SvgPicture.asset("assets/svg/lock_edite_profile.svg"),
                              if (!isSwitch) const SizedBox(width: 16),
                              Text(
                                "Change Password",
                                style: AppStyle.appBarStyle,
                              ),
                              const Spacer(),
                              CupertinoSwitch(
                                  value: isSwitch,
                                  onChanged: (e) {
                                    setState(() {
                                      isSwitch = !isSwitch;
                                      if(!isSwitch){
                                        isLoginPasswordError1=false;
                                        isLoginPasswordError2=false;
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        if (isSwitch)
                          Column(
                            children: [
                              const SizedBox(height: 24),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                child: inputPasswordWidget(
                                  onChanged: (e) {
                                    setState(() {
                                      if (e.length < 8) {
                                        isLoginPasswordError1 = true;
                                        password1 = "8ta belgi dan kambomasin";
                                      } else if (validatePasswordCustom(e) ?? false) {
                                        isLoginPasswordError1 = true;
                                        password1 = "8ta belgi dan kambomasin";
                                      } else {
                                        isLoginPasswordError1 = false;
                                        password1 = null;
                                      }
                                    });
                                  },
                                  textEditingController: passwordController1,
                                  onTapEye: () {
                                    setState(() {
                                      isEye0 = !isEye0;
                                    });
                                  },
                                  isEye: isEye0,
                                  password: password1,
                                  isLoginError: isLoginPasswordError1,
                                  onTap: () {
                                    setState(() {
                                      isFieldPassword1 = true;
                                    });
                                    if (passwordController2.text.isEmpty) {
                                      isFieldPassword2 = false;
                                    }
                                    if (firstNameController.text.isEmpty) {
                                      isFieldFirstName = false;
                                    }
                                    if (lastNameController.text.isEmpty) {
                                      isFieldLasName = false;
                                    }
                                  },
                                  isField: isFieldPassword1,
                                  onFieldSubmitted: () {
                                    if (passwordController1.text.isEmpty) {
                                      setState(() {
                                        isFieldPassword1 = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              if (password1 != null) const SizedBox(height: 10),
                              if (password1 != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 30),
                                    Text(
                                      password1 ?? "",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(color: AppColors.red),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 24),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                child: inputPasswordWidget(
                                  textEditingController: passwordController2,
                                  onTapEye: () {
                                    setState(() {
                                      isEye1 = !isEye1;
                                    });
                                  },
                                  isEye: isEye1,
                                  onChanged: (e) {
                                    setState(() {
                                      if (passwordController1.text == e) {
                                        isLoginPasswordError2 = false;
                                      } else {
                                        isLoginPasswordError2 = true;
                                      }
                                    });
                                  },
                                  password: password2,
                                  isLoginError: isLoginPasswordError2,
                                  onTap: () {
                                    setState(() {
                                      isFieldPassword2 = true;
                                    });
                                    if (passwordController1.text.isEmpty) {
                                      isFieldPassword1 = false;
                                    }
                                    if (firstNameController.text.isEmpty) {
                                      isFieldFirstName = false;
                                    }
                                    if (lastNameController.text.isEmpty) {
                                      isFieldLasName = false;
                                    }
                                  },
                                  isField: isFieldPassword2,
                                  onFieldSubmitted: () {
                                    if (passwordController2.text.isEmpty) {
                                      setState(() {
                                        isFieldPassword2 = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              if (password2 != null) const SizedBox(height: 10),
                              if (password2 != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 30),
                                    Text(
                                      password2 ?? "",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(color: AppColors.red),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 120,
                          child: ScrollablePositionedList.builder(
                            physics:const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 33,
                            initialScrollIndex: widget.profileResponse?.avatarId!.toInt()??1,
                            itemScrollController: itemScrollController,
                            scrollOffsetController: scrollOffsetController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetListener: scrollOffsetListener,
                            itemBuilder: (context, i) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if ((avatarItem != i && avatarItem > i - 1)) const SizedBox(width: 14),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (i == avatarItem)
                                      SvgPicture.asset(
                                        "assets/svg/avatar_background.svg",
                                        height: 104,
                                        width: 104,
                                      ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            avatarItem = i;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg_avatar/avatar$i.svg",
                                          height: avatarItem == i ? 90 : 80,
                                          width: avatarItem == i ? 90 : 80,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (avatarItem != i && avatarItem < i + 1) const SizedBox(width: 14),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: Container(
        height: 80,
        alignment: Alignment.bottomCenter,
        color: isLoaded ? AppColors.white : AppColors.whiteAccent,
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: buttonLogin(
            onPressed: () {
              if (isSwitch && !isLoginPasswordError1 && !isLoginPasswordError2&&passwordController1.text.isNotEmpty&&passwordController2.text.isNotEmpty) {
                context.read<ProfileBloc>().add(ProfileUpdateEvent(firstName: firstNameController.text, lastName: lastNameController.text, avatar: avatarItem, password: passwordController1.text));
              } else if(isSwitch){
                isLoginPasswordError1=true;
                isLoginPasswordError2=true;
                setState(() {

                });
              }
              else {
                context.read<ProfileBloc>().add(ProfileUpdateNoPasswordEvent(firstName: firstNameController.text, lastName: lastNameController.text, avatar: avatarItem));
              }
            },
            label: "Save Changes",
            isActive: true),
      ),
    );
  }
}
