import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/style/app_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../style/app_colors.dart';
import '../../widgets/button_login.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool isLogin = false;
  bool isEye = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  final maskCardFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final cvv = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final expiryDAte = MaskTextInputFormatter(
    mask: '##/##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  FocusNode cvvFocus=FocusNode();
  FocusNode expiryDateFocus=FocusNode();
  FocusNode nameFocus=FocusNode();
  FocusNode numberFocus=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [
                0.1,
                0.7,
                0.8,
                0.4,
              ],
              colors: [
                AppColors.whiteAccent,
                AppColors.greenAccent.withOpacity(0.8),
                AppColors.whiteAccent,
                AppColors.whiteAccent,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/done.svg",
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "- - - - - - - - - -",
                                    style: TextStyle(color: AppColors.onProgress),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    "assets/svg/on_progress_2.svg",
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "- - - - - - - - - -",
                                    style: TextStyle(color: AppColors.onProgress),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    "assets/svg/status.svg",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: AppColors.white,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                              color: AppColors.white,
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 220),
                                  Row(
                                    children: [
                                      Text(
                                        "199kr/ ",
                                        style: AppStyle.tariff0,
                                      ),
                                      Text("30 dagar", style: AppStyle.tariff1),
                                      const Spacer(),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            backgroundColor: AppColors.greenAccent,
                                            minimumSize: const Size(139, 35)),
                                        onPressed: () {
                                          showMyDialog(context:context,isBonus:true,isIsland: false);
                                        },
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Rabattkod",
                                                style: AppStyle.loginButton,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.delete_outline_outlined,
                                                  color: AppColors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 58.0,
                                    child: TextFormField(
                                      controller: nameController,
                                      onChanged: (e) {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.name,
                                      // initialValue: 'sathyabaman@gmail.com',
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Card name',
                                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.name),
                                        contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
                                        isDense: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // const Text(
                                  //   "Card number",
                                  //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.nameF),
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  SizedBox(
                                    height: 58.0,
                                    child: TextFormField(
                                      focusNode: numberFocus,
                                      controller: cardNumberController,
                                      onChanged: (e) {
                                        if(e.length==19){
                                          numberFocus.unfocus();
                                        }
                                        setState(() {});
                                      },
                                      inputFormatters: [maskCardFormatter],
                                      keyboardType: TextInputType.number,
                                      // initialValue: 'sathyabaman@gmail.com',
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: 'Card number',
                                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.name),
                                        contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
                                        isDense: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // const Text(
                                            //   "Expiry Date",
                                            //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.nameF),
                                            // ),
                                            // const SizedBox(
                                            //   height: 8,
                                            // ),
                                            SizedBox(
                                              height: 58.0,
                                              // width: 150,
                                              child: TextFormField(
                                                controller: expiryDateController,
                                                focusNode: expiryDateFocus,
                                                onChanged: (e) {
                                                  if(e.length==8){
                                                    expiryDateFocus.unfocus();
                                                  }
                                                  setState(() {});

                                                },
                                                inputFormatters: [expiryDAte],
                                                keyboardType: TextInputType.number,
                                                // initialValue: 'sathyabaman@gmail.com',
                                                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                                decoration: InputDecoration(
                                                  hintText: 'Expiry Date',
                                                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.name),
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
                                                  isDense: true,
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // const Text(
                                            //   "CVV",
                                            //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.nameF),
                                            // ),
                                            // const SizedBox(
                                            //   height: 8,
                                            // ),
                                            SizedBox(
                                              height: 58.0,
                                              // width: 140,
                                              child: TextFormField(
                                                controller: cvvController,
                                                focusNode: cvvFocus,
                                                onChanged: (e) {
                                                  if(e.length==3){
                                                    cvvFocus.unfocus();
                                                  }
                                                  setState(() {});
                                                },
                                                inputFormatters: [cvv],
                                                keyboardType: TextInputType.number,
                                                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                                                decoration: InputDecoration(
                                                  hintText: 'cvv',
                                                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.name),
                                                  contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
                                                  isDense: true,
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              height: 50,
                                              width: 50,
                                              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: AppColors.greenAccent,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/svg/exit.svg",
                                                color: AppColors.white,
                                              ))),
                                      SizedBox(
                                        width: 228,
                                        child: buttonLogin(
                                            onPressed: () {
                                              successDialog(context, () {
                                                 Navigator.pushNamed(context, RouteList.checkScreen);
                                              });
                                            },
                                            label: "Confirm",
                                            isActive: emailController.text.length > 10),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 140,
                  right: 21,
                  left: 21,
                  child: Center(
                    child: Container(
                      // height: 215,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/png/rectangle.png",
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 24, left: 24),
                            child: const Text(
                              "SoCard",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 33),
                          Container(
                            margin: const EdgeInsets.only(top: 24, left: 24),
                            child: Text(
                              cardNumberController.text,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 39),
                          Row(
                            children: [
                              const SizedBox(
                                width: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Card holder name",
                                    style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: 10),
                                  ),
                                  Text(
                                    nameController.text,
                                    style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: 14),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Expiry date",
                                    style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: 10),
                                  ),
                                  Text(
                                    expiryDateController.text,
                                    style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  )),
              // Positioned(
              //     bottom: 12,
              //     right: 21,
              //     left: 21,
              //     child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     GestureDetector(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Container(
              //             height: 50,
              //             width: 50,
              //             padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(30),
              //               color: AppColors.greenAccent,
              //             ),
              //             child: SvgPicture.asset(
              //               "assets/svg/exit.svg",
              //               color: AppColors.white,
              //             ))),
              //     SizedBox(
              //       width: 228,
              //       child: buttonLogin(
              //           onPressed: () {
              //             Navigator.pushNamed(context, RouteList.checkCodeScreen);
              //           },
              //           label: "Confirm",isActive: emailController.text.length>10),
              //     ),
              //   ],
              // )
              // )
            ],
          ),
        ),
      ),
    );
  }
}
